extends Node

func fizzy_enter(target, fsm, data) -> void:
    print("idle enter")

func fizzy_exit(target, fsm, data) -> void:
    print("idle exit")

func fizzy_input(target, fsm, event: InputEvent):
    if event is InputEventKey and event.is_pressed():
        match event.as_text():
            "Left":
                fsm.transition_to("walking", { "direction": "left" })
            "Right":
                fsm.transition_to("walking", { "direction": "right" })
