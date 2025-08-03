extends Area2D

class_name Player

signal player_health_changed(value: float)
signal player_mana_changed(value: float)
signal player_coins_changed(value: int)

var max_health:= 100.:
	set(value):
		max_health = value
		Signals.emit_signal("update_max_health", max_health)
		full_heal()
var max_mana:= 1500.:
	set(value):
		max_mana = value
		Signals.emit_signal("update_max_mana", max_mana)

var health: float = max_health:
	set(value):
		health = clamp(value, 0, max_health)
		emit_signal("player_health_changed", value)
		if health == 0:
			Signals.emit_signal("game_over")
		
var mana: float = max_mana:
	set(value):
		mana = clamp(value, 0, max_mana)
		emit_signal("player_mana_changed", value)

var coins: int = 0:
	set(value):
		coins = value
		emit_signal("player_coins_changed", coins)

var damage_per_loop: float = 100
var maximum_projectile_hit_before_break: int = 1

@onready var base_sprite_color = %Sprite2D.modulate

func _ready() -> void:
	Signals.end_wave.connect(full_heal)

func _on_body_entered(body: Node2D) -> void:
	take_damage(body)

func _on_area_entered(area: Area2D) -> void:
	take_damage(area)

func take_damage(body: Node2D):
	if "damage" in body:
		health -= body.damage
		show_damage_number(body.damage, body.global_position)
		AudioManager.get_node("%PlayerDamaged").play()
		var damage_tween = damage_tween()
		body.queue_free()

func full_heal():
	health = max_health
	regen_mana()

func regen_mana():
	mana = max_mana

func damage_tween() -> Tween:
	var tween = get_tree().create_tween()
	if %Sprite2D:
		tween.tween_property(%Sprite2D, "modulate", Color(3, 0.25, 0.25), 0.2)
		tween.chain().tween_property(%Sprite2D, "modulate", base_sprite_color, 0.2)
	return tween

func _process(delta: float) -> void:
	position = get_viewport().get_visible_rect().size / 2.0

func show_damage_number(damage_value: int, body_position: Vector2) -> void:
	var damage_label = Label.new()
	#damage_label.modulate = Color(213./255., 96./255., 73./255., 0)
	damage_label.global_position = body_position
	damage_label.text = str(damage_value)
	damage_label.top_level = true
	damage_label.set("theme_override_font_sizes/font_size", 50)
	damage_label.modulate.a = 0
	add_child(damage_label)
	await fade_in_out_animation(damage_label).finished
	damage_label.queue_free()

func fade_in_out_animation(label: Label) -> Tween:
	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate:a", 1, 2).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.chain().tween_property(label, "modulate:a", 0, 1.5).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	return tween
