extends Control

func _ready() -> void:
    Signals.end_wave.connect(open_shop)
    hide()

func open_shop():
    show()


func _on_next_wave_button_pressed() -> void:
    hide()
    Signals.emit_signal("new_wave")
