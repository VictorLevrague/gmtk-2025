extends Control

@export var player: Player
@export var possible_upgrades: Array[Upgrade]

var simutaneous_nb_of_upgrades = 3

func _ready() -> void:
    Signals.end_wave.connect(open_shop)
    Signals.player_upgrade.connect(player_upgrade)
    hide()

func open_shop():
    show()
    init_upgrades()
    disable_upgrade_buttons(false)
    %AnimationPlayer.play("scale_up")

func init_upgrades():
    clear_upgrade_container()
    possible_upgrades.shuffle()
    var selected_upgrades: Array[Upgrade]
    if len(possible_upgrades) >= simutaneous_nb_of_upgrades:
        selected_upgrades = possible_upgrades.slice(0, simutaneous_nb_of_upgrades)
    else:
        selected_upgrades = possible_upgrades.slice(0, len(possible_upgrades))
    for upgrade in selected_upgrades:
        var upgrade_ui = load("res://src/ui/ui_elements/upgrade_ui.tscn").instantiate()
        upgrade_ui.upgrade = upgrade
        %UpgradeContainer.add_child(upgrade_ui)

func _on_next_wave_button_pressed() -> void:
    hide()
    AudioManager.get_node("%ButtonClick1").play()
    Signals.emit_signal("new_wave")

func player_upgrade(upgrade: Upgrade):
    if player:
        upgrade.upgrade_function(player)
        possible_upgrades.erase(upgrade)
        if upgrade.unlocked_upgrade:
            possible_upgrades.append(upgrade.unlocked_upgrade)
    disable_upgrade_buttons(true)

func disable_upgrade_buttons(are_disabled: bool):
    for upgrade_ui in %UpgradeContainer.get_children():
        upgrade_ui.get_node("%Button").disabled = are_disabled
        upgrade_ui.stop_animation()
    if are_disabled:
        %AnimationPlayer.play("reset_scale_up")
    %NextWaveButton.disabled = not are_disabled

func clear_upgrade_container():
    for upgrade_ui in %UpgradeContainer.get_children():
        upgrade_ui.queue_free()
