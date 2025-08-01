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
            queue_free()
@export var damage: float = 10
@export var coins: int = 10

var knockback: Vector2
var knockback_strength = 40

func _physics_process(delta: float) -> void:
    var center_screen = get_viewport_rect().size / 2.0
    #look_at(center_screen)
    velocity = (center_screen - position).normalized() * speed
    add_knockback()
    var collider = move_and_collide(velocity * delta)
    if collider:
        collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * knockback_strength

func add_knockback():
    knockback = knockback.move_toward(Vector2.ZERO, 1)
    velocity += knockback

func take_damage(damage: float):
    var tween = damage_tween()
    await tween.finished
    health -= damage

func damage_tween() -> Tween:
    var tween = get_tree().create_tween()
    if %Sprite2D:
        tween.tween_property(%Sprite2D, "modulate", Color(3, 0.25, 0.25), 0.2)
        tween.chain().tween_property(%Sprite2D, "modulate", Color(1, 1, 1), 0.2)
    return tween
