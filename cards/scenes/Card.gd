extends Node2D

class_name Card

export(String, "clubs", "diamonds", "hearts", "spades") var suit = "clubs"
export(String, "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A") var rank = "2"

export(bool) var face_down = false setget set_face_down
export(bool) var draggable = true setget set_draggable

var card_data

func _ready() -> void:
    card_data = CardData.new(suit, rank)
    set_face_down(face_down)

func set_face_down(value) -> void:
    face_down = value

    if card_data == null:
        return

    if face_down:
        $Draggable.texture = card_data.back
    else:
        $Draggable.texture = card_data.front

func set_draggable(value) -> void:
    draggable = value
    $Draggable.enabled = value
