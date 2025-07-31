extends Area2D

class_name Player

signal player_health_changed(value: float)
signal player_mana_changed(value: float)
signal player_coins_changed(value: int)

var regen_mana_rate = 10
var max_health:= 100.
var max_mana:= 100.

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

func _ready() -> void:
    Signals.end_wave.connect(full_heal)

func _on_body_entered(body: Node2D) -> void:
    take_damage(body)

func _on_area_entered(area: Area2D) -> void:
    take_damage(area)

func take_damage(body: Node2D):
    if "damage" in body:
        health -= body.damage
        body.queue_free()

func _process(delta: float) -> void:
    regen_mana(delta)

func regen_mana(delta):
    mana += regen_mana_rate * delta

func full_heal():
    health = max_health
    mana = max_mana
