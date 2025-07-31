extends Node2D

@export var enemies: Array[PackedScene]

var distance:= 1000

func _on_timer_timeout() -> void:
    spawn(get_random_position())

func spawn(position: Vector2):
    var enemy_instance = enemies[randi_range(0, enemies.size() - 1)].instantiate()
    enemy_instance.position = position
    add_child(enemy_instance)

func get_random_position() -> Vector2:
    var center_screen = get_viewport_rect().size / 2.0
    return center_screen + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
