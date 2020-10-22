extends Node

export (PackedScene) var Ball


export(int) var ballLimit = 5

signal ball_spawned

onready var _spawnZone = $BallSpawnZone

var _createdBallCount = 0

func _input(event):
    if event.is_action_pressed("click") && _createdBallCount < ballLimit:
        _createdBallCount += 1
        var new_ball = Ball.instance()
        emit_signal("ball_spawned", ballLimit - _createdBallCount, new_ball)
        new_ball.position = _spawnZone.transform.get_origin()
        add_child(new_ball)

func reset():
    _createdBallCount = 0
