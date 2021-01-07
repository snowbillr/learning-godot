extends Node2D

export(Resource) var card_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $Draggable/Sprite.texture = card_data.front
