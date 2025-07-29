extends Label

@export var base_text: String
@export var slider: Slider

func _ready() -> void:
    slider.value_changed.connect(_on_slider_value_changed)

func _on_slider_value_changed(value: float) -> void:
    text = base_text % [str(int(value*100))]
