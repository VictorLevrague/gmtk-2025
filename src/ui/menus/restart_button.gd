extends Button

func _on_pressed() -> void:
    AudioManager.get_node("%ButtonClick1").play()
    get_tree().paused = false
    get_tree().reload_current_scene()
