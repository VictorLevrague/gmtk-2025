extends TextureButton

func _on_pressed() -> void:
    AudioManager.get_node("%ButtonClick1").play()
    print("pressed")
    %Options.visible = not %Options.visible
    get_tree().paused = not get_tree().paused 
