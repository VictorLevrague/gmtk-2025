extends Node2D

@export var wave_id: int = 0:
    set(value):
        wave_id = value
        Signals.emit_signal("update_wave_id", wave_id)

@export var enemies: Array[PackedScene]
@export var wave_duration: float = 30
@export var maximum_nb_enemies_on_screen: int = 20
@export var spawn_speed: float = 1.5
@export var gold_per_enemy: int

var spawn_distance:= 700

func _ready() -> void:
    Signals.new_wave.connect(new_wave)
    new_wave()

func _on_timer_timeout() -> void:
    spawn(get_random_position())

func new_wave() -> void:
    wave_id += 1
    %SpawnerTimer.wait_time = spawn_speed
    %WaveTimer.wait_time = wave_duration
    %WaveTimer.start()
    %SpawnerTimer.start()

func spawn(position: Vector2):
    if %Enemies.get_child_count() < maximum_nb_enemies_on_screen and enemies.size():
        var enemy_instance = enemies[randi_range(0, enemies.size() - 1)].instantiate()
        enemy_instance.position = position
        %Enemies.add_child(enemy_instance)
    else:
        print("Nb enemies is max")

func get_random_position() -> Vector2:
    var center_screen = get_viewport_rect().size / 2.0
    return center_screen + spawn_distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func _on_wave_timer_timeout() -> void:
    %SpawnerTimer.stop()
    %WaveTimer.stop()
    clear_enemies()
    Signals.emit_signal("end_wave")

func clear_enemies():
    for enemy in %Enemies.get_children():
        enemy.queue_free()
