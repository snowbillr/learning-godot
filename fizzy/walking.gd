extends FizzyState

export(int) var speed = 200
var direction

func fizzy_enter(data) -> void:
    direction = data["direction"]
    target.get_node("Sprite").rotation = direction.x * PI / 8

    fsm.register_transition_trigger("idle", funcref(self, "_idle_trigger"))
    fsm.register_transition_trigger("walking", funcref(self, "_turnaround_trigger"))
    fsm.register_transition_trigger("sprint", funcref(self, "_sprint_trigger"))

func fizzy_exit(data) -> void:
    target.get_node("Sprite").rotation = 0

func fizzy_process(delta):
    target.position += direction * speed * delta

func _idle_trigger():
    if direction == Vector2.LEFT and Input.is_action_just_released("ui_left"):
        return true
    elif direction == Vector2.RIGHT and Input.is_action_just_released("ui_right"):
        return true
    return null

func _turnaround_trigger():
    if direction == Vector2.LEFT and Input.is_action_just_pressed("ui_right"):
        return { "direction": Vector2.RIGHT }
    elif direction == Vector2.RIGHT and Input.is_action_just_pressed("ui_left"):
        return { "direction": Vector2.LEFT }
    return null

func _sprint_trigger():
    if Input.is_action_pressed("sprint"):
        return direction
    return null
