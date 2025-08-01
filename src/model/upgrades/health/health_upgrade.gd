extends Upgrade

var texture: Texture2D = load("res://assets/icons/coeurs.png")
var name: String = "Health"
@export var max_health_gain: int

func upgrade_function(player: Player):
    player.max_health += max_health_gain
