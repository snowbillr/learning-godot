tool
extends Sprite

enum GEM_TYPE {
    CIRCLE,
    TRIANGLE,
    DIAMOND
}

export(GEM_TYPE) var gem_type = GEM_TYPE.CIRCLE setget _set_gem_type

func _ready() -> void:
    _set_gem_type(gem_type)

func _set_gem_type(value):
    gem_type = value
    match gem_type:
        GEM_TYPE.CIRCLE:
            frame = 0
        GEM_TYPE.TRIANGLE:
            frame = 2
        GEM_TYPE.DIAMOND:
            frame = 4

func randomize():
    gem_type = randi() % 3

#
