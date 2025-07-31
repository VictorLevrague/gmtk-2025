extends CharacterBody2D

class_name enemy

@export var speed: float = 75
@export var health: float = 100:
    set(value):
        health = clamp(value, 0, 100)
        if health == 0:
            queue_free()
@export var damage: float = 10
var knockback: Vector2
var knockback_strength = 80

func _physics_process(delta: float) -> void:
    var center_screen = get_viewport_rect().size / 2.0
    velocity = (center_screen - position).normalized() * speed
    print("knockback: ", knockback)
    add_knockback()
    var collider = move_and_collide(velocity * delta)
    if collider:
        collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * knockback_strength

func add_knockback():
    knockback = knockback.move_toward(Vector2.ZERO, 1)
    velocity += knockback
