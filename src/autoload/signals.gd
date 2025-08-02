extends Node

signal update_wave_id(wave_id: int)
signal update_wave_time(wave_time: float)
signal update_max_health(health: float)
signal update_max_mana(mana: float)
signal end_wave
signal new_wave
signal game_over
signal victory
signal update_damage(level: int)
signal update_protection(level: int)

signal player_upgrade(upgrade: Upgrade)
