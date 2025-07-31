extends TextureButton

func _on_pressed() -> void:
    %Options.visible = not %Options.visible
    get_tree().paused = not get_tree().paused 
