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

    fsm.register_transition_trigger("idle", funcref(self, "_idle_trigger"))

func fizzy_exit(target, fsm, data) -> void:
    target.get_node("Sprite").rotation = 0

func fizzy_process(target, fsm, delta):
    target.position += direction * speed * delta

func _idle_trigger(target):
    if direction == Vector2.LEFT and Input.is_action_just_released("ui_left"):
        return true
    elif direction == Vector2.RIGHT and Input.is_action_just_released("ui_right"):
        return true
    return null
