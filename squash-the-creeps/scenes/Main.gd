extends Node

export (PackedScene) var mob_scene

func _ready() -> void:
    randomize()
    $UserInterface/Retry.hide()

func _on_MobTimer_timeout() -> void:
    var mob = mob_scene.instance()
    var mob_spawn_location = $SpawnPath/SpawnLocation
    mob_spawn_location.unit_offset = randf()

    var player_position = $Player.transform.origin

    add_child(mob)
    mob.initialize(mob_spawn_location.translation, player_position)

    mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")

func _on_Player_hit() -> void:
    $MobTimer.stop()
    $UserInterface/Retry.show()

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
        get_tree().reload_current_scene()
