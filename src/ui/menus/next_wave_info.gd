extends Control

@export var enemies: Array[PackedScene]

signal hide_all

func _ready() -> void:
    init_enemy_icons()

func init_enemy_icons():
    for child in %GridContainer.get_children():
        child.queue_free()
    for enemy in enemies:
        var new_texture = TextureRect.new()
        new_texture.expand_mode = TextureRect.EXPAND_KEEP_SIZE
        new_texture.stretch_mode = TextureRect.STRETCH_KEEP
        new_texture.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
        new_texture.size_flags_vertical = Control.SIZE_SHRINK_CENTER
        var enemy_instance = enemy.instantiate()
        new_texture.texture = enemy_instance.get_node("%Sprite2D").texture
        new_texture.modulate = enemy_instance.get_node("%Sprite2D").modulate
        enemy_instance.queue_free()
        %GridContainer.add_child(new_texture)
        

func _on_next_wave_button_pressed() -> void:
    AudioManager.get_node("%ButtonClick2").play()
    emit_signal("hide_all")
    Signals.emit_signal("new_wave")
