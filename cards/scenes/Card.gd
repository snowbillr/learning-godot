extends Node2D

export(Resource) var card_data

export(bool) var face_down = false setget set_face_down
export(bool) var draggable = true setget set_draggable

func _enter_tree() -> void:
    set_face_down(face_down)

func _ready() -> void:
    pass

func set_face_down(value) -> void:
    face_down = value
    if face_down:
        $Draggable.texture = card_data.back
    else:
        $Draggable.texture = card_data.front

func set_draggable(value) -> void:
    draggable = value
    $Draggable.enabled = value
