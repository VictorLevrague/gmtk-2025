extends Upgrade

var texture: Texture2D = load("res://assets/icons/bulles.png")
var name: String = "Projectile Protection"

@export var projectile_protection_increase: int = 1

func upgrade_function(player: Player):
    player.maximum_projectile_hit_before_break += projectile_protection_increase
