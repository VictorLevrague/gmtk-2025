extends Panel

@export var upgrade: Upgrade:
    set(value):
        upgrade = value
        %Name.text = upgrade.name
        %Level.text = "Level %s" % [str(upgrade.level)]
        %Icon.texture = upgrade.texture

func _on_button_pressed() -> void:
    Signals.emit_signal("player_upgrade", upgrade)
