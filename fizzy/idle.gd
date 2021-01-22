extends Node

func fizzy_enter(target, fsm, data) -> void:
    fsm.register_transition_trigger("walking", funcref(self, "_walking_trigger"))

func fizzy_exit(target, fsm, data) -> void:
    print("idle exit")

#func fizzy_input(target, fsm, event: InputEvent):
#    if event is InputEventKey and event.is_pressed():
#        match event.as_text():
#            "Left":
#                fsm.transition_to("walking", { "direction": "left" })
#            "Right":
#                fsm.transition_to("walking", { "direction": "right" })

func _walking_trigger(target):
    if Input.is_action_just_pressed("ui_left"):
        return { "direction": "left" }
    if Input.is_action_just_pressed("ui_right"):
        return { "direction": "right" }
    return null
