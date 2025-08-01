extends Control

func _ready() -> void:
    hide()
    Signals.victory.connect(victory)

func victory():
    show()
    get_tree().paused = true
