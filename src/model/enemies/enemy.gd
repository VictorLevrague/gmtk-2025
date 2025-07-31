extends CharacterBody2D

class_name enemy

@export var speed: float = 75
@export var health: float = 100:
    set(value):
        health = clamp(value, 0, 100)
        if health == 0:
            queue_free()
@export var damage: float = 10

func _physics_process(delta: float) -> void:
    var center_screen = get_viewport_rect().size / 2.0
    velocity = (center_screen - position).normalized() * speed
    move_and_collide(velocity * delta)
