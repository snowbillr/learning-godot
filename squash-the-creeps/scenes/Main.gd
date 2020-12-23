extends Node

export (PackedScene) var mob_scene

func _ready() -> void:
    randomize()


func _on_MobTimer_timeout() -> void:
    var mob = mob_scene.instance()
    var mob_spawn_location = $SpawnPath/SpawnLocation
    mob_spawn_location.unit_offset = randf()

    var player_position = $Player.transform.origin

    add_child(mob)
    mob.initialize(mob_spawn_location.translation, player_position)


func _on_Player_hit() -> void:
    $MobTimer.stop()
