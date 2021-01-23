extends Node

class_name FizzyState

var target
var fsm: FizzyMachine

func fizzy_enter(data) -> void:
    pass

func fizzy_exit(data) -> void:
    pass

func fizzy_process(delta: float) -> void:
    pass

func fizzy_physics_process(delta: float) -> void:
    pass

func fizzy_input(event: InputEvent) -> void:
    pass

func fizzy_unhandled_input(event: InputEvent) -> void:
    pass
