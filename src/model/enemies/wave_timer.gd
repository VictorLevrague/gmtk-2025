extends Timer

func _process(_delta: float) -> void:
    Signals.emit_signal('update_wave_time', %WaveTimer.get_time_left())
