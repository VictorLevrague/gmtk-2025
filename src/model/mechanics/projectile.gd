extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed: float = 100
var damage: float = 5

func _physics_process(delta: float) -> void:
    position += direction * speed * delta
