extends Node2D

@export var projectile_scene: PackedScene

func _on_timer_timeout() -> void:
    var projectile = projectile_scene.instantiate()
    projectile.position = position
    projectile.direction = (get_viewport_rect().size / 2.0 - global_position).normalized()
    add_child(projectile)
