extends Node2D

var is_dragging := false
var shadow

func _ready() -> void:
    var sprite_width = $Sprite.texture.get_width()
    var sprite_height = $Sprite.texture.get_height()
    $Shadow.margin_left = -sprite_width / 2
    $Shadow.margin_right = sprite_width / 2
    $Shadow.margin_top = -sprite_height / 2
    $Shadow.margin_bottom = sprite_height / 2
    $Shadow.rect_position += Vector2(0, 10)
    $Shadow.visible = false

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and is_dragging:
        position += event.relative

func _on_Area2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event is InputEventMouseButton:
        is_dragging = event.is_pressed()
        $Shadow.visible = is_dragging
        if is_dragging:
            position.y -= 10
        else:
            position.y += 10

