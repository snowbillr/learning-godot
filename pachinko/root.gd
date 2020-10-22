extends Node

var Main = preload("res://Main.tscn")
var Persistor = load("res://scripts/Persistor.gd")

onready var game_over = $"game-over"

onready var main = $Main

func _ready():
    game_over.hide()
    main.connect("game_over", self, "_on_Main_game_over")
    game_over.connect("play_again", self, "_on_GameOver_play_again")

func _on_Main_game_over(score):
    var persistor = Persistor.new()

    var old_high_score = persistor.load_high_score()
    game_over.score = score
    game_over.old_high_score = old_high_score

    if (score > old_high_score):
        persistor.save_high_score(score)

    get_tree().paused = true
    game_over.show()

func _on_GameOver_play_again():
    main.queue_free()
    main = Main.instance()
    main.connect("game_over", self, "_on_Main_game_over")
    game_over.hide()
    add_child(main)
    move_child(main, 0)
    get_tree().paused = false
