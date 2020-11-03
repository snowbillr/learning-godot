extends Node2D
tool

export(Resource) var boon_1 setget _set_boon_1
export(Resource) var boon_2 setget _set_boon_2

onready var line = $Line2D

func _set_boon_1(value) -> void:
    boon_1 = value
    _update_line()

func _set_boon_2(value) -> void:
    boon_2 = value
    _update_line()

func _update_line() -> void:
    if !line:
        line = $Line2D

    if boon_1 && boon_2:
        print("updating line")
        print(boon_1.position)
        print(boon_2.position)
        line.clear_points()
        line.add_point(boon_1.position)
        line.add_point(boon_2.position)
