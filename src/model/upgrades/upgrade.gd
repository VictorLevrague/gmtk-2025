extends Resource

class_name Upgrade

@export var name: String
@export var level: int
@export var texture: Texture2D
@export var unlocked_upgrade: Upgrade

func upgrade_function(player: Player):
    pass
