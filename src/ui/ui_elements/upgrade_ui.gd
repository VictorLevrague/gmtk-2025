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

func _on_button_mouse_entered() -> void:
    if not %Button.disabled:
        %AnimationPlayer.play("rotation")

func _on_button_mouse_exited() -> void:
    stop_animation()

func stop_animation() -> void:
    var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "rotation", 0, 0.2)
    await tween.finished
    %AnimationPlayer.stop()
