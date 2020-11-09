extends Node2D
tool

class_name Boon

export(Resource) var boon_data setget _set_boon_data

func _set_boon_data(value) -> void:
    boon_data = value

    if $Sprite:
        $Sprite.texture = value.icon
    if $Title:
        $Title.text = value.title

    if $Slots/Attack:
        $Slots/Attack.visible = boon_data.attack
    if $Slots/Special:
        $Slots/Special.visible = boon_data.special
    if $Slots/Cast:
        $Slots/Cast.visible = boon_data.cast
    if $Slots/Dash:
        $Slots/Dash.visible = boon_data.dash
    if $Slots/Call:
        $Slots/Call.visible = boon_data.call
