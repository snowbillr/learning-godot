extends Node

var speed = 200
var direction

func fizzy_enter(target, fsm, data) -> void:
    print("walking enter")
    if data["direction"] == "left":
        direction = Vector2.LEFT
        target.get_node("Sprite").rotation = -PI / 8
    else:
        direction = Vector2.RIGHT
        target.get_node("Sprite").rotation = PI / 8

func fizzy_exit(target, fsm, data) -> void:
    target.get_node("Sprite").rotation = 0

func fizzy_process(target, fsm, delta):
    target.position += direction * speed * delta

func fizzy_input(target, fsm, event: InputEvent):
    if event is InputEventKey and !event.is_pressed():
        match event.as_text():
            "Left":
                fsm.transition_to("idle", {})
            "Right":
                fsm.transition_to("idle", {})
