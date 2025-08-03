extends Node2D

@export var projectile_scene: PackedScene

@export var shoot_frequency: float = 5.:
    set(value):
        shoot_frequency = value
        %Timer.wait_time = shoot_frequency

func _on_timer_timeout() -> void:
    var projectile = projectile_scene.instantiate()
    projectile.position = position
    projectile.direction = (get_viewport().get_visible_rect().size / 2.0 - global_position).normalized()
    add_child(projectile)
