tool
extends Node2D

class_name Bucket

export(int) var points setget set_points

signal ball_caught

onready var particles = $Particles2D

var _caughtBalls := []

func _on_BallDetector_body_entered(body: RigidBody2D) -> void:
    $AudioStreamPlayer.play()

    particles.position.x = body.global_position.x - self.global_position.x
    particles.position.y = body.global_position.y - self.global_position.y
    particles.emitting = true

    if !_caughtBalls.has(body.get_instance_id()):
        _caughtBalls.append(body.get_instance_id())
        emit_signal("ball_caught", points)

func set_points(value):
    points = value
    $points.text = str(value)
