extends Panel

func _ready() -> void:
    hide()

func _input(event: InputEvent) -> void:
    if Input.is_action_pressed("ui_cancel"):
        AudioManager.get_node("%ButtonClick1").play()
        visible = not visible
        get_tree().paused = not get_tree().paused

func _on_close_button_pressed() -> void:
    AudioManager.get_node("%ButtonClick2").play()
    visible = false
    get_tree().paused = false
