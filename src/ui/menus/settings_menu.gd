extends Panel

func _ready() -> void:
    hide()

func _input(event: InputEvent) -> void:
    if Input.is_action_pressed("ui_cancel"):
        visible = not visible
        get_tree().paused = not get_tree().paused

func _on_close_button_pressed() -> void:
    visible = false
    get_tree().paused = false
