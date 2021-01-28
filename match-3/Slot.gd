extends Sprite

var board_position: Vector2
var gem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

func add_gem(_gem):
    gem = _gem
    add_child(gem)

func remove_gem():
    remove_child(gem)
    gem = null
