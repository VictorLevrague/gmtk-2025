extends Panel

var ANIMATION_DURATION = 0.1

var maximum: float

func set_and_animate(value: float):
    var tween = create_tween()
    tween.tween_property(material, "shader_parameter/HealthAmount", value/maximum, ANIMATION_DURATION)
    await tween.finished
