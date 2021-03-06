extends Node2D

export(Texture) var texture setget _set_texture
export(bool) var enabled := true
export(String) var draggable_group_name

var is_dragging := false

onready var sprite = $Sprite
onready var shadow = $Shadow
onready var tween = $Tween
onready var handle = $Area2D/CollisionShape2D

func _ready() -> void:
    _set_texture(texture)

    var sprite_width = sprite.texture.get_width()
    var sprite_height = sprite.texture.get_height()

    shadow.margin_left = -sprite_width / 2
    shadow.margin_right = sprite_width / 2
    shadow.margin_top = -sprite_height / 2
    shadow.margin_bottom = sprite_height / 2
    shadow.rect_position += Vector2(0, 10)
    shadow.visible = false

    handle.shape.extents = Vector2(sprite_width / 2, sprite_height / 2)

func _set_texture(value):
    texture = value
    if has_node("Sprite"):
        $Sprite.texture = value

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and is_dragging:
        global_position += event.relative

func _on_Area2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if not enabled:
        return

    if event is InputEventMouseButton:
        is_dragging = event.is_pressed()
        shadow.visible = is_dragging

        tween.stop_all()
        if is_dragging:
            start_dragging()
        else:
            stop_dragging()

func start_dragging():
    is_dragging = true

    tween.stop_all()

    var draggable_group = get_tree().get_nodes_in_group(draggable_group_name)
    var max_z_index = 0
    for item in draggable_group:
        max_z_index = max(max_z_index, item.z_index)
    for item in draggable_group:
        if item.is_a_parent_of(self):
            item.z_index = max_z_index + 1

    tween.interpolate_property(sprite, "offset:y", sprite.offset.y, -10, 0.2, Tween.TRANS_QUART, Tween.EASE_OUT)
    tween.interpolate_property(sprite, "scale", sprite.scale, sprite.scale + Vector2(0.05, 0.05), 0.2, Tween.TRANS_QUART, Tween.EASE_OUT)
    tween.start()

func stop_dragging():
    is_dragging = false

    tween.interpolate_property(sprite, "offset:y", sprite.offset.y, 0, 0.2, Tween.TRANS_QUART, Tween.EASE_OUT)
    tween.interpolate_property(sprite, "scale", sprite.scale, sprite.scale - Vector2(0.05, 0.05), 0.2, Tween.TRANS_QUART, Tween.EASE_OUT)
    tween.start()
