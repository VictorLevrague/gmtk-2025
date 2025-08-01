extends Node2D

@export var initial_wave: PackedScene

var wave_duration: float

var wave_id: int = 0:
    set(value):
        wave_id = value
        Signals.emit_signal("update_wave_id", wave_id)

func _ready() -> void:
    Signals.new_wave.connect(new_wave)
    new_wave()

func new_wave() -> void:
    wave_id += 1
    var new_wave_to_instantiate
    if wave_id != 1:
        var current_wave = %EnemySpawners.get_child(0)
        new_wave_to_instantiate = current_wave.next_wave.instantiate()
        current_wave.queue_free()
    else:
        new_wave_to_instantiate = initial_wave.instantiate()
    wave_duration = new_wave_to_instantiate.wave_duration
    %EnemySpawners.add_child(new_wave_to_instantiate)
    %WaveTimer.wait_time = wave_duration
    %WaveTimer.start()
    start_all_enemy_spawn_timers()

func _on_wave_timer_timeout() -> void:
    %WaveTimer.stop()
    stop_all_enemy_spawn_timers()
    if wave_id == 19:
        Signals.emit_signal("victory")
    else:
        Signals.emit_signal("end_wave")

func start_all_enemy_spawn_timers():
    for enemy_spawner in %EnemySpawners.get_child(0).get_children():
        enemy_spawner.get_node("%SpawnerTimer").start()

func stop_all_enemy_spawn_timers():
    for enemy_spawner in %EnemySpawners.get_child(0).get_children():
        enemy_spawner.get_node("%SpawnerTimer").stop()
        enemy_spawner.clear_enemies()
