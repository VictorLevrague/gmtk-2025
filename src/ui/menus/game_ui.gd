extends Control

@export var player: Player

func _ready() -> void:
    if player:
        player.player_health_changed.connect(%Health.set_and_animate)
        player.player_mana_changed.connect(%Mana.set_and_animate)
        player.player_coins_changed.connect(update_coins)
        Signals.update_max_health.connect(update_max_health)
        Signals.update_max_mana.connect(update_max_mana)
        Signals.update_damage.connect(update_damage)
        Signals.update_protection.connect(update_protection)
        %Health.maximum = player.max_health
        %Mana.maximum = player.max_mana #update when stat is modified
        %Health.set_and_animate(player.max_health)
        %Mana.set_and_animate(player.max_mana)
    Signals.update_wave_id.connect(update_wave_id)
    Signals.update_wave_time.connect(update_wave_time)

func update_wave_id(wave_id: int) -> void:
    var base_text = "Wave n°%s/20"
    %WaveNumber.text = base_text % [wave_id]

func update_wave_time(wave_time_left: float) -> void:
    %WaveTime.text = str(ceili(wave_time_left))

func update_coins(value: int):
    %CoinLabel.text = str(value)

func update_max_health(max_health: float):
    %Health.maximum = max_health

func update_max_mana(max_mana: float):
    %Mana.maximum = max_mana

func update_damage(damage_per_loop: int):
    %StrengthLabel.text = str(damage_per_loop)

func update_protection(total_protection: int):
    %ProtectionLabel.text = str(total_protection - 1)
