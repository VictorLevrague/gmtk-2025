extends Control

func _ready() -> void:
    Signals.upgrade_chosen.connect(_on_upgrade_chosen)

func _on_upgrade_chosen():
    if %WaveManager.get_node("%EnemySpawners").get_child_count():
        var enemies: Array[PackedScene] = []
        var next_wave = %WaveManager.get_node("%EnemySpawners").get_child(0).next_wave.instantiate()
        if next_wave.get_child_count():
            for enemy_spawner in next_wave.get_children():
                for enemy_type in enemy_spawner.enemies:
                    if enemy_type not in enemies:
                        enemies.append(enemy_type)
        %Shop.get_node("%NextWaveInfoLayer").enemies = enemies
