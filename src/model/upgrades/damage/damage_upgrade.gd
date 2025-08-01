extends Upgrade

@export var damage_upgrade: int = 20

func upgrade_function(player: Player):
    player.damage_per_loop += damage_upgrade
