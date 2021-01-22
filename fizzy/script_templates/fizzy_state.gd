extends %BASE%

func fizzy_enter(target, fsm, data)%VOID_RETURN%:
    pass

func fizzy_exit(target, fsm, data)%VOID_RETURN%:
    pass

func fizzy_process(target, fsm, delta%FLOAT_TYPE%)%VOID_RETURN%:
    pass

func fizzy_physics_process(target, fsm, delta%FLOAT_TYPE%)%VOID_RETURN%:
    pass

func fizzy_input(target, fsm, event: InputEvent)%VOID_RETURN%:
    pass

func fizzy_unhandled_input(target, fsm, event: InputEvent)%VOID_RETURN%:
    pass
