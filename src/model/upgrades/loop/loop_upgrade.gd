extends Upgrade

var texture: Texture2D = load("res://assets/icons/potion.png")
var name: String = "Mana"

@export var max_line_length: int = 200

func upgrade_function(player: Player):
    player.max_mana += max_line_length
