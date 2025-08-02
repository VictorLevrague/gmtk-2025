extends Area2D

var direction: Vector2 = Vector2.RIGHT
@export var speed: float = 100
@export var damage: float = 5

func _physics_process(delta: float) -> void:
    global_position += direction * speed * delta
