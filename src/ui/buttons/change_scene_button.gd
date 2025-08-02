extends Button

@export var next_scene: PackedScene

func _on_pressed() -> void:
    AudioManager.get_node("%ButtonClick2").play()
    get_tree().change_scene_to_packed(next_scene)
