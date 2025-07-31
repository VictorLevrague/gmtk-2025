extends Control

@export var player: Player

func _ready() -> void:
    if player:
        player.player_health_changed.connect(%Health.set_and_animate)
        player.player_mana_changed.connect(%Mana.set_and_animate)
        player.player_coins_changed.connect(update_coins)
    Signals.update_wave_id.connect(update_wave_id)
    Signals.update_wave_time.connect(update_wave_time)

func update_wave_id(wave_id: int) -> void:
    var base_text = "Wave n°%s"
    %WaveNumber.text = base_text % [wave_id]

func update_wave_time(wave_time_left: float) -> void:
    %WaveTime.text = str(ceili(wave_time_left))

func update_coins(value: int):
    %CoinLabel.text = str(value)
