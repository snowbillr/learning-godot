extends RigidBody2D

signal ball_exited

func _ready() -> void:
    var xDirection = 1 if randi() % 2 else -1
    var xForce = rand_range(50, 200)
    var yForce = rand_range(-100, -200)

    apply_central_impulse(Vector2(xForce * xDirection, yForce))


func _on_VisibilityNotifier2D_screen_exited() -> void:
    emit_signal("ball_exited")
