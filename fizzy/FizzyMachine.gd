extends Node

class_name FizzyMachine

export(String) var initial_state_name = ""
export(NodePath) var target_path = null

var target = null
var states = []
var current_state: Node = null
var current_state_transition_triggers = []

func _ready() -> void:
    target = get_node(target_path)
    states = get_children()

    for state in states:
        state.target = target
        state.fsm = self

    transition_to(initial_state_name, {})

func transition_to(state_name: String, data) -> void:
    if current_state and current_state.has_method("fizzy_exit"):
        current_state.fizzy_exit(data)
        current_state_transition_triggers = []

    current_state = _get_state_by_name(state_name)

    if current_state.has_method("fizzy_enter"):
        current_state.fizzy_enter(data)

func register_transition_trigger(to: String, trigger) -> void:
    current_state_transition_triggers.append({
        "to": to,
        "trigger": trigger
    })

func _process(delta: float) -> void:
    if current_state and current_state.has_method("fizzy_process"):
        current_state.fizzy_process(delta)

    for transition_trigger in current_state_transition_triggers:
        var trigger_value = transition_trigger["trigger"].call_func()
        if trigger_value != null:
            print("transition triggered to " + transition_trigger["to"])
            transition_to(transition_trigger["to"], trigger_value)
            break;

func _physics_process(delta: float) -> void:
    if current_state and current_state.has_method("fizzy_physics_process"):
        current_state.fizzy_physics_process(delta)

func _input(event: InputEvent) -> void:
    if current_state and current_state.has_method("fizzy_input"):
        current_state.fizzy_input(event)

func _unhandled_input(event: InputEvent) -> void:
    if current_state and current_state.has_method("fizzy_unhandled_input"):
        current_state.fizzy_unhandled_input(event)

func _get_state_by_name(state_name: String) -> Node:
    for state in states:
        if state.name == state_name:
            return state
    return null
