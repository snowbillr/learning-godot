extends Node

var target
var fsm: FizzyMachine

var speed = 400
var finished = false
var direction

func fizzy_enter(data) -> void:
    direction = data
    target.get_node("Sprite").rotation = direction.x * PI / 8
    finished = false
    $Timer.start()

    fsm.register_transition_trigger("idle", funcref(self, "_idle_trigger"))
    fsm.register_transition_trigger("walking", funcref(self, "_walking_trigger"))

func fizzy_exit(data) -> void:
    target.get_node("Sprite").rotation = 0

func fizzy_process(delta: float) -> void:
    target.position += direction * speed * delta

func fizzy_physics_process(delta: float) -> void:
    pass

func fizzy_input(event: InputEvent) -> void:
    pass

func fizzy_unhandled_input(event: InputEvent) -> void:
    pass

func _idle_trigger():
    if finished and not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
        return true
    return null

func _walking_trigger():
    if finished:
        if Input.is_action_pressed("ui_left"):
            return { "direction": Vector2.LEFT }
        if Input.is_action_pressed("ui_right"):
            return { "direction": Vector2.RIGHT }
    return null

func _on_Timer_timeout() -> void:
    finished = true
