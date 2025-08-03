extends Upgrade

var texture: Texture2D = load("res://assets/icons/dama_color.png")
var name: String = "Loop Damage"
@export var damage_upgrade: int = 20

func upgrade_function(player: Player):
    player.damage_per_loop += damage_upgrade
    Signals.emit_signal("update_damage", player.damage_per_loop)
