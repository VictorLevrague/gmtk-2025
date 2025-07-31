extends Panel

var ANIMATION_DURATION = 0.3

func set_and_animate(value: float):
    var tween = create_tween()
    tween.tween_property(material, "shader_parameter/HealthAmount", value/100, ANIMATION_DURATION)
    await tween.finished
