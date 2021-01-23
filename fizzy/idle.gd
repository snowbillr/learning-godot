extends FizzyState

func fizzy_enter(data) -> void:
    fsm.register_transition_trigger("walking", funcref(self, "_walking_trigger"))

func _walking_trigger():
    if Input.is_action_pressed("ui_left"):
        return { "direction": Vector2.LEFT }
    if Input.is_action_pressed("ui_right"):
        return { "direction": Vector2.RIGHT }
    return null
