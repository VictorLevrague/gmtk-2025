extends Area2D

class_name Player

signal player_health_changed(value: float)
signal player_mana_changed(value: float)

var regen_mana_rate = 10

var health: float = 100:
    set(value):
        health = clamp(value, 0, 100.)
        emit_signal("player_health_changed", value)
        
var mana: float = 100:
    set(value):
        mana = clamp(value, 0, 100.)
        emit_signal("player_mana_changed", value)

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
