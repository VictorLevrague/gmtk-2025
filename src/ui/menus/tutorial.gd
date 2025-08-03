extends Control

var text_1: String = "You stole the Loop Maker, an ancient power hidden in Atlantis.\t

Try to use your power by holding the left mouse button to draw now !"

var text_2: String = "Awesome !\t

Now, to protect your power, you have to surround your enemies with loops.\t

Draw a loop around a fish to repel it. \t
"

var text_3: String = "Perfect !\t

You can also draw lines to absorb a projectile.\t

Future upgrades will allow you to absorb more during the same drawing. \t
"

var text_4: String = "Now, protect Atlantis against hordes of fish.\t

Upgrade your health, mana, loop damage and projectile protection along the way.\t

Good luck !
"

#Now, to protect it, you have to surround your enemies with loops.

var tutorial_texts: Array[String] = [text_1, text_2, text_3, text_4]

var current_tutorial: int = 0:
    set(value):
        current_tutorial = value
        if current_tutorial == 3:
            %ContinueButton.text = "Play"
        

func _ready() -> void:
    %GameUI.get_node("%WaveInfo").hide()
    AudioManager.get_node("%ButtonClick1").play()
    %TutorialLabel.text = tutorial_texts[current_tutorial]
    %Player.player_mana_changed.connect(_on_player_mana_changed)
    %TutorialSpawner.get_node("%SpawnerTimer").stop()
    Signals.enemy_eliminated.connect(_on_enemy_eliminated)
    %ContinueButton.disabled = true

func _on_continue_button_pressed() -> void:
    AudioManager.get_node("%ButtonClick2").play()
    current_tutorial += 1
    if current_tutorial < tutorial_texts.size():
        %TutorialLabel.text = tutorial_texts[current_tutorial]
    %ContinueButton.disabled = true
    if current_tutorial == 1:
        %TutorialSpawner.enemies.append(load("res://src/model/enemies/basic_enemy.tscn"))
        %TutorialSpawner.spawn_speed = 22.5
        %TutorialSpawner._on_timer_timeout()
        %TutorialSpawner.get_node("%SpawnerTimer").start()
    if current_tutorial == 2:
        %TutorialSpawner.enemies.remove_at(0)
        %TutorialSpawner.enemies.append(load("res://src/model/enemies/canon_enemy.tscn"))
        %TutorialSpawner.spawn_speed = 22.5
        %TutorialSpawner._on_timer_timeout()
        %TutorialSpawner.get_node("%SpawnerTimer").start()
    if current_tutorial == 3:
        %ContinueButton.disabled = false
    if current_tutorial == 4:
        get_tree().change_scene_to_packed(load("res://src/ui/menus/game.tscn"))

func _on_player_mana_changed(value: float):
    if value <= 0:
        print("value 0")
        %ContinueButton.disabled = false

func _on_enemy_eliminated():
    %ContinueButton.disabled = false
    %TutorialSpawner.get_node("%SpawnerTimer").stop()
