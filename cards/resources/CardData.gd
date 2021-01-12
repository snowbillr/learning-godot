extends Resource

class_name CardData

export(String) var suit
export(String) var rank

export(Texture) var front
export var back = preload("res://assets/images/cards/BackRed.png")

func _init(_suit, _rank) -> void:
    suit = _suit
    rank = _rank
    front = load("res://assets/images/cards/" + suit + "/" + rank + ".png")
