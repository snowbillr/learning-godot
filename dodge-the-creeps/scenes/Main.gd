extends Node

export(PackedScene) var mob_scene

var score

func _ready():
    randomize()

func game_over() -> void:
    $ScoreTimer.stop()
    $MobTimer.stop()
    $HUD.show_game_over()

func new_game() -> void:
    score = 0
    get_tree().call_group("mobs", "queue_free")
    $HUD.update_score(score)
    $HUD.show_message("Get Ready")
    $Player.start($StartPosition.position)
    $StartTimer.start()

func _on_StartTimer_timeout() -> void:
    $MobTimer.start()
    $ScoreTimer.start()

func _on_ScoreTimer_timeout() -> void:
    score += 1
    $HUD.update_score(score)

func _on_MobTimer_timeout() -> void:
    var mob_spawn_location = $MobPath/MobSpawnLocation
    mob_spawn_location.offset = randi()

    var mob = mob_scene.instance()
    add_child(mob)

    var direction = mob_spawn_location.rotation + PI / 2
    direction += rand_range(-PI / 4, PI / 4)
    mob.rotation = direction

    mob.position = mob_spawn_location.position

    var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
    mob.linear_velocity = velocity.rotated(direction)
