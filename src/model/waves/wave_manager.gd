extends Node2D

@export var wave: Wave:
    set(value):
        wave = value
        %EnemySpawner.wave = wave

func _on_wave_timer_timeout() -> void:
    %EnemySpawner.get_node("%SpawnerTimer").stop()
    %WaveTimer.stop()
    %EnemySpawner.clear_enemies()
    Signals.emit_signal("end_wave")
