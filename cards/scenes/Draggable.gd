extends Node2D

export(Texture) var texture
export(bool) var enabled = true

var is_dragging := false

onready var sprite = $Sprite
onready var shadow = $Shadow
onready var tween = $Tween

func _ready() -> void:
    sprite.texture = texture

    var sprite_width = sprite.texture.get_width()
    var sprite_height = sprite.texture.get_height()
    shadow.margin_left = -sprite_width / 2
    shadow.margin_right = sprite_width / 2
    shadow.margin_top = -sprite_height / 2
    shadow.margin_bottom = sprite_height / 2
    shadow.rect_position += Vector2(0, 10)
    shadow.visible = false

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and is_dragging:
        position += event.relative

func _on_Area2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if not enabled:
        return

    if event is InputEventMouseButton:
        is_dragging = event.is_pressed()
        $Shadow.visible = is_dragging

        tween.stop_all()
        if is_dragging:
            tween.interpolate_property($Sprite, "offset:y", $Sprite.offset.y, -10, 0.2, Tween.TRANS_QUART, Tween.EASE_OUT)
            tween.start()
        else:
            tween.interpolate_property($Sprite, "offset:y", $Sprite.offset.y, 0, 0.2, Tween.TRANS_QUART, Tween.EASE_OUT)
            tween.start()

