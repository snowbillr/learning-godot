extends Node

class_name Game

signal game_over

onready var remainingBallsValue = $hud/RemainingBallsValue
onready var scoreValue = $hud/ScoreValue
onready var ballSpawner = $BallSpawner

var _score := 0
var _buckets = []
var _ballDoneCount := 0

func _ready() -> void:
    scoreValue.text = str(_score)

    _buckets = get_tree().get_nodes_in_group("buckets")
    for _bucket in _buckets:
        var bucket := _bucket as Bucket
        var error := bucket.connect("ball_caught", self, "_on_Bucket_ball_caught")

func _process(_delta: float) -> void:
    if _ballDoneCount == 5:
        emit_signal("game_over", _score)

func _on_BallSpawner_ball_spawned(remainingBalls, newBall) -> void:
    remainingBallsValue.text = str(remainingBalls)
    newBall.connect("ball_exited", self, "_on_Ball_ball_exited")

func _on_Bucket_ball_caught(points) -> void:
    _ballDoneCount += 1
    _score += points
    scoreValue.text = str(_score)

func _on_Ball_ball_exited() -> void:
    _ballDoneCount += 1

func reset() -> void:
    $BallSpawner.ballLimit = 5
    _score = 0
    _ballDoneCount = 0
