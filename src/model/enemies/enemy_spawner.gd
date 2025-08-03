extends Node2D

@export var enemies: Array[PackedScene]
@export var maximum_nb_enemies_on_screen: int = 20
@export var spawn_distance:= 700
@export var gold_per_enemy: int

@export var spawn_speed: float = 1.5:
    set(value):
        spawn_speed = value
        %SpawnerTimer.wait_time = value

func _ready() -> void:
    %SpawnerTimer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
    spawn(get_random_position())

func spawn(position: Vector2):
    if %Enemies.get_child_count() < maximum_nb_enemies_on_screen and enemies.size():
        var enemy_instance = enemies[randi_range(0, enemies.size() - 1)].instantiate()
        enemy_instance.position = position
        %Enemies.add_child(enemy_instance)
        enemy_instance.fade_in()
    else:
        print("Nb enemies is max")

func get_random_position() -> Vector2:
    #var center_screen = get_viewport_rect().size / 2.0
    var center_screen = get_viewport().get_visible_rect().size / 2.0
    return global_position + spawn_distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func clear_enemies():
    for enemy in %Enemies.get_children():
        enemy.queue_free()
