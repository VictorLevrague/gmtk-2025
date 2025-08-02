extends ColorRect

func _ready() -> void:
    show()
    await fade_out_tween().finished
    hide()

func fade_out_tween() -> Tween:
    var tween = create_tween()
    tween.tween_property(self, "modulate:a", 0, 2).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
    return tween
