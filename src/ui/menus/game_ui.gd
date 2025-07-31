extends Control

@export var player: Player

func _ready() -> void:
    if player:
        player.player_health_changed.connect(%Health.set_and_animate)
        player.player_mana_changed.connect(%Mana.set_and_animate)
