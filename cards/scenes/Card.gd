extends Node2D

export(Resource) var card_data

func _enter_tree() -> void:
    $Draggable.texture = card_data.front

func _ready() -> void:
    pass
