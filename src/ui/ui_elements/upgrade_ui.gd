extends Panel

@export var upgrade: Upgrade:
    set(value):
        upgrade = value
        if upgrade.name:
            %Name.text = upgrade.name
        %Level.text = "Level %s" % [str(upgrade.level)]
        if upgrade.texture:
            %Icon.texture = upgrade.texture

func _on_button_pressed() -> void:
    AudioManager.get_node("%ButtonClick2").play()
    Signals.emit_signal("player_upgrade", upgrade)
