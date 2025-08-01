extends Upgrade

@export var max_health_gain: int

func upgrade_function(player: Player):
    player.max_health += max_health_gain
