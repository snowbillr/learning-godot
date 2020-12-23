extends KinematicBody

signal hit

export var speed = 14
export var fall_acceleration = 75
export var jump_impulse = 20
export var bounce_impulse = 16

var velocity = Vector3.ZERO

func _physics_process(delta: float) -> void:
    var direction = Vector3.ZERO

    if Input.is_action_pressed("move_left"):
        direction.x -= 1
    if Input.is_action_pressed("move_right"):
        direction.x += 1
    if Input.is_action_pressed("move_backward"):
        direction.z += 1
    if Input.is_action_pressed("move_forward"):
        direction.z -= 1

    if direction != Vector3.ZERO:
        direction = direction.normalized()
        $Pivot.look_at(translation + direction, Vector3.UP)

        $AnimationPlayer.playback_speed = 4
    else:
        $AnimationPlayer.playback_speed = 1

    velocity.x = direction.x * speed
    velocity.z = direction.z * speed
    velocity.y -= fall_acceleration * delta

    if is_on_floor() && Input.is_action_pressed("jump"):
        velocity.y += jump_impulse

    velocity = move_and_slide(velocity, Vector3.UP)

    for i in range(get_slide_count()):
        var collision = get_slide_collision(i)
        if collision.collider.is_in_group("mobs"):
            var mob = collision.collider
            if Vector3.UP.dot(collision.normal) > 0.1:
                mob.squash()
                velocity.y += bounce_impulse

    $Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

func die() -> void:
    emit_signal("hit")
    queue_free()

func _on_MobDetector_body_entered(body: Node) -> void:
    die()
