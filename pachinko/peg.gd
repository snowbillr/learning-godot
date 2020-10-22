extends RigidBody2D

onready var soundFx = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    angular_velocity = 3 * pow(-1, randi() % 2)


func _on_Area2D_body_entered(body: Node) -> void:
    print("callback")


func _on_RigidBody2D_body_entered(body: Node) -> void:
    $AudioStreamPlayer.play()
