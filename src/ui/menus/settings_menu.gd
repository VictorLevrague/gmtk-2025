extends Panel

func _input(event: InputEvent) -> void:
    if Input.is_action_pressed("ui_cancel"):
        visible = not visible
