extends Button

func _on_pressed() -> void:
    AudioManager.get_node("%ButtonClick").play()
