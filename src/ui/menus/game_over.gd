extends Control

func _ready() -> void:
    hide()
    Signals.game_over.connect(game_over)

func game_over():
    show()
    get_tree().paused = true
