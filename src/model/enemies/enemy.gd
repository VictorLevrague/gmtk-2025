extends CharacterBody2D

class_name enemy

@export var speed: float = 35
@export var max_health = 100:
    set(value):
        max_health = value
        health = max_health
var health: float = max_health:
    set(value):
        health = clamp(value, 0, max_health)
        if health <= 0:
            #AudioManager.get_node("%EnemyElimination").play()
            queue_free()
@export var damage: float = 10
@export var coins: int = 10

var knockback: Vector2
var knockback_strength = 40

func _physics_process(delta: float) -> void:
    var center_screen = get_viewport_rect().size / 2.0
    velocity = (center_screen - global_position).normalized() * speed
    if %Sprite2D:
        %Sprite2D.flip_v = false if velocity.x > 0.1 else true
    look_at(center_screen)
    add_knockback()
    var collider = move_and_collide(velocity * delta)
    if collider:
        collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * knockback_strength

func add_knockback():
    knockback = knockback.move_toward(Vector2.ZERO, 1)
    velocity += knockback

func take_damage(damage: float):
    AudioManager.get_node("%EnemyElimination").play()
    var tween = damage_tween()
    await tween.finished
    health -= damage

func damage_tween() -> Tween:
    var tween = get_tree().create_tween()
    if %Sprite2D:
        var base_color = %Sprite2D.modulate
        tween.tween_property(%Sprite2D, "modulate", Color(3, 0.25, 0.25), 0.2)
        tween.chain().tween_property(%Sprite2D, "modulate", base_color, 0.2)
    return tween

func fade_in() -> void:
    var tween = create_tween()
    if %Sprite2D:
        %Sprite2D.modulate.a = 0
        tween.tween_property(%Sprite2D, "modulate:a", 1, 0.5).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
