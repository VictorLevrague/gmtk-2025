extends HSlider

@export var audio_bus_name: String

var audio_bus_index: int

func _ready() -> void:
    audio_bus_index = AudioServer.get_bus_index(audio_bus_name)
    value_changed.connect(_on_value_changed)
    value = db_to_linear(AudioServer.get_bus_volume_db(audio_bus_index))

func _on_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(audio_bus_index, linear_to_db(value))
