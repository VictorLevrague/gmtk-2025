extends TextureButton

func _on_pressed() -> void:
    AudioManager.get_node("%ButtonClick1").play()
    %Options.visible = not %Options.visible
    get_tree().paused = not get_tree().paused 
