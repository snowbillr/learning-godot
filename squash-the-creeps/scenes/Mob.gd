extends KinematicBody

signal squashed

export var min_speed := 10
export var max_speed := 18

var velocity = Vector3.ZERO

func initialize(start_position: Vector3, player_position: Vector3):
    translation = start_position

    look_at(player_position, Vector3.UP)
    rotate_y(rand_range(-PI / 4, PI / 4))

    velocity = Vector3.FORWARD * rand_range(min_speed, max_speed)
    velocity = velocity.rotated(Vector3.UP, rotation.y)

func _physics_process(delta: float) -> void:
    move_and_slide(velocity)


func _on_VisibilityNotifier_screen_exited() -> void:
    queue_free()

func squash() -> void:
    emit_signal("squashed")
    queue_free()
