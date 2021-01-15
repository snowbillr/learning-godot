extends Node2D

onready var stack = $Stack
onready var highlight = $Highlight

var hovering_card: Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

func add_card(card: Card):
    card.get_node("Draggable").stop_dragging()
    card.get_parent().remove_child(card)
    stack.add_child(card)
    card.scale = Vector2(1, 1)
    card.position = Vector2(0, 0)
    print(stack.global_position)
    print(stack.position)
    print(card.global_position)
    print(card.position)

func _on_Area2D_area_entered(area: Area2D) -> void:
    highlight.visible = true
    hovering_card = area.get_parent().get_parent()

func _on_Area2D_area_exited(area: Area2D) -> void:
    highlight.visible = false
    hovering_card = null

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and not event.is_pressed() and hovering_card != null:
        highlight.visible = false
        add_card(hovering_card)
        hovering_card = null


