extends FizzyState

export(int) var speed = 400
var finished = false
var direction

func fizzy_enter(data) -> void:
    finished = false

    direction = data
    target.get_node("Sprite").rotation = direction.x * PI / 8
    $Timer.start()

    fsm.register_transition_trigger("idle", funcref(self, "_idle_trigger"))
    fsm.register_transition_trigger("walking", funcref(self, "_walking_trigger"))

func fizzy_exit(data) -> void:
    target.get_node("Sprite").rotation = 0

func fizzy_process(delta: float) -> void:
    target.position += direction * speed * delta

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
