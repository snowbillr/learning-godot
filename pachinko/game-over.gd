extends Control

signal play_again

export (int) var old_high_score := 0 setget _set_old_high_score
export (int) var score := 0 setget _set_score

onready var playAgainButton = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func _on_Button_pressed() -> void:
    emit_signal("play_again")

func _set_old_high_score(value):
    old_high_score = value
    $HighScoreValue.text = str(value)
    if (value < score):
        print("new high score")
        $NewHighScoreValue.text = str(score)
        $HighScoreValue.modulate = Color(0.3, 0.3, 0.3)
    else:
        $NewHighScoreValue.text = ''
        $HighScoreValue.modulate = Color(1, 1, 1)

func _set_score(value):
    score = value
    $ScoreValue.text = str(value)
