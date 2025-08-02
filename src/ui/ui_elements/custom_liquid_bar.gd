extends Panel

@export var base_text: String
@export var label: Label

var ANIMATION_DURATION = 0.1

var maximum: float:
    set(value):
        maximum = value
        label.text = base_text + ": " + str(int(bar_value)) + "/" +  str(int(maximum))

var bar_value: float:
    set(value):
        bar_value = clamp(value, 0, maximum)
        label.text = base_text + ": " + str(int(bar_value)) + "/" +  str(int(maximum))

func set_and_animate(value: float):
    var tween = create_tween()
    tween.tween_property(material, "shader_parameter/HealthAmount", value/maximum, ANIMATION_DURATION)
    tween.set_parallel()
    tween.tween_property(self, "bar_value", value, ANIMATION_DURATION)
    await tween.finished
