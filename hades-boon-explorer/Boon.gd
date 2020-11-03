extends Node2D
tool

class_name Boon

export(Resource) var boon_data setget _set_boon_data

onready var sprite = $Sprite
onready var titleLabel = $Title

func _set_boon_data(value) -> void:
    boon_data = value

    if $Sprite:
        $Sprite.texture = value.icon
    if $Title:
        $Title.text = value.title
