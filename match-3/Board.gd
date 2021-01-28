extends Node2D

var Slot = preload("res://Slot.tscn")
var Gem = preload("res://Gem.tscn")

export(int) var rows = 4
export(int) var columns = 4

const DIRECTION_THRESHOLD = 0.8

var slots = []
var is_dragging := false
var drag_slot

func _ready() -> void:
    for row in range(0, rows):
        slots.append([])
        for col in range(0, columns):
            var slot = Slot.instance()
            slot.position = Vector2(row * 32, col * 32)
            slot.board_position = Vector2(row, col)
            slots[row].append(slot)
            add_child(slot)

            var gem = Gem.instance()
            gem.randomize()
            slot.add_gem(gem)

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.is_pressed():
            is_dragging = true
            drag_slot = _get_slot_for_global_position(event.position)
        elif not event.is_pressed():
            var end_position = to_local(event.position)
            var direction = (end_position - drag_slot.position).normalized()
            if direction.x > DIRECTION_THRESHOLD:
                direction = Vector2.RIGHT
            elif direction.x < -DIRECTION_THRESHOLD:
                direction = Vector2.LEFT
            elif direction.y > DIRECTION_THRESHOLD:
                direction = Vector2.DOWN
            elif direction.y < -DIRECTION_THRESHOLD:
                direction = Vector2.UP

            var target_position = drag_slot.board_position + direction
            if target_position.x < 0 or target_position.x > columns - 1:
                shake_slot(drag_slot, direction)
                return
            elif target_position.y < 0 or target_position.y > rows - 1:
                shake_slot(drag_slot, direction)
                return

            var target_slot = slots[target_position.x][target_position.y]
            swap_gems(drag_slot, target_slot)

            is_dragging = false
            drag_slot = null

func _get_slot_for_global_position(position: Vector2):
    var slot_position = to_local(position).snapped(Vector2(32, 32)) / 32
    return slots[slot_position.x][slot_position.y]

func shake_slot(slot, direction):
    var shake_factor = 5
    var shake_count = 2
    var gem = slot.gem

    for i in range(0, shake_count):
        $ShakeTween.interpolate_property(gem, "position", gem.position, gem.position + direction * shake_factor, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
        $ShakeTween.start()
        yield($ShakeTween, "tween_all_completed")

        $ShakeTween.interpolate_property(gem, "position", gem.position, gem.position - direction * shake_factor, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
        $ShakeTween.start()
        yield($ShakeTween, "tween_all_completed")


func swap_gems(slot_1, slot_2):
    var gem_1 = slot_1.gem
    var gem_2 = slot_2.gem
    var gem_1_position = Vector2(gem_1.global_position)
    var gem_2_position = Vector2(gem_2.global_position)
    $SwapTween.interpolate_property(gem_1, "global_position", gem_1_position, gem_2_position, 0.3, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
    $SwapTween.interpolate_property(gem_2, "global_position", gem_2_position, gem_1_position, 0.3, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
    $SwapTween.start()

    yield($SwapTween, "tween_all_completed")

    slot_1.remove_gem()
    slot_2.remove_gem()
    slot_1.add_gem(gem_2)
    slot_2.add_gem(gem_1)

    gem_1.position = Vector2.ZERO
    gem_2.position = Vector2.ZERO

func reparent(gem, new_slot):
    var old_slot = gem.get_parent()
    old_slot.remove_gem()
    new_slot.add_gem(gem)
