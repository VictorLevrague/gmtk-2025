extends Upgrade

@export var max_line_length: int = 200

func upgrade_function(player: Player):
    player.max_mana += max_line_length
