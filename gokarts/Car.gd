extends KinematicBody2D
class_name Car

# Car initially points at (0, -1)

const ACCELERATION = 500
const MAX_VELOCITY = 1000

const FRICTION = 200

const MAX_WHEEL_ROTATION = PI / 60
const WHEEL_ANGULAR_VELOCITY = PI / 12
const WHEEL_RETURN_ANGULAR_VELOCITY = PI / 4

var _velocity = Vector2.ZERO
var _wheel_rotation = 0

func _process(delta: float) -> void:
    # tmp_velocity rotated back to vertical
    var tmp_velocity = _velocity.rotated(-1 * rotation)

    # apply acceleration to tmp_velocity
    var acceleration_strength = _get_acceleration_strength()
    if !is_zero_approx(acceleration_strength):
        tmp_velocity.y += acceleration_strength * ACCELERATION * delta
    elif abs(tmp_velocity.y) < 0.05:
        tmp_velocity.y = 0
    elif !is_zero_approx(tmp_velocity.y):
        tmp_velocity.y += sign(tmp_velocity.y) * -1 * FRICTION * delta

    tmp_velocity.y = clamp(tmp_velocity.y, -MAX_VELOCITY, MAX_VELOCITY)

    # apply rotation

    # rotate wheel angle
    var turn_strength = _get_turn_strength()
    if !is_zero_approx(turn_strength):
        _wheel_rotation += turn_strength * WHEEL_ANGULAR_VELOCITY * delta
    elif abs(_wheel_rotation) < 0.05:
        _wheel_rotation = 0
    elif !is_zero_approx(_wheel_rotation):
        _wheel_rotation += sign(_wheel_rotation) * -1 * WHEEL_RETURN_ANGULAR_VELOCITY * delta
    _wheel_rotation = clamp(_wheel_rotation, -MAX_WHEEL_ROTATION, MAX_WHEEL_ROTATION)

    # apply wheel rotation to overall rotation
    var velocity_factor = tmp_velocity.length() / MAX_VELOCITY
    # shouldn't be able to turn the car as fast at lower speeds

    var drifting_factor = 1
    if _is_drifting():
        drifting_factor = 1.4
        $DriftTrailLeft.emitting = true
        $DriftTrailRight.emitting = true
    else:
        $DriftTrailLeft.emitting = false
        $DriftTrailRight.emitting = false

    if _is_accelerating():
        $ExhaustTrail.emitting = true
    else:
        $ExhaustTrail.emitting = false

    rotation += _wheel_rotation * velocity_factor * drifting_factor

    if _is_drifting():
        _velocity = (tmp_velocity * 0.98).rotated(rotation)
    else:
        _velocity = tmp_velocity.rotated(rotation)

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

func _is_drifting() -> bool:
    return Input.get_action_strength("drift") > 0

func _is_accelerating() -> bool:
    return _get_acceleration_strength() < 0 && _velocity.length() < MAX_VELOCITY
