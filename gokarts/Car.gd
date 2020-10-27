extends KinematicBody2D

const ACCELERATION = 800
const MAX_SPEED = 400
const FRICTION = 300
const TURN_VELOCITY = PI

var _input_velocity = null
var _velocity = Vector2.ZERO

func _process(delta: float) -> void:
    var turn_amount = _get_turn_strength() * TURN_VELOCITY * delta

    rotation += turn_amount

    _velocity = _velocity.rotated(turn_amount)

    var input_velocity = Vector2.ZERO
    input_velocity.y += _get_acceleration_strength() * ACCELERATION * delta
    input_velocity = input_velocity.rotated(rotation)

    _velocity += input_velocity

    if _velocity.length() > 0 && input_velocity.length() == 0:
        _velocity = _velocity.move_toward(Vector2.ZERO, FRICTION * delta)

    _velocity = _velocity.clamped(MAX_SPEED)

func _physics_process(delta: float) -> void:
    move_and_slide(_velocity)

func _get_acceleration_strength() -> float:
    var acceleration_strength = -1 * Input.get_action_strength("accelerate")
    var deceleration_strength = Input.get_action_strength("decelerate")

    return acceleration_strength + deceleration_strength

func _get_turn_strength() -> float:
    var left_strength = Input.get_action_strength("turn_left") * -1
    var right_strength = Input.get_action_strength("turn_right")
    return left_strength + right_strength

