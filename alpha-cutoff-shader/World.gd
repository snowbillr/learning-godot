extends Node2D

const TRANSITION_SOURCE_DIRECTORY = "res://transitions/"

var transition_sources = []

onready var sprite = $Sprite
onready var animation_player = $Sprite/AnimationPlayer
onready var button_container = $ColorRect/VBoxContainer

func _init() -> void:
    var directory = Directory.new()
    if (directory.open(TRANSITION_SOURCE_DIRECTORY) == OK):
        directory.list_dir_begin()
        var file_name = directory.get_next()
        while file_name != "":
            if not file_name.ends_with(".import") and not file_name == "." and not file_name == "..":
                transition_sources.append(load(TRANSITION_SOURCE_DIRECTORY + file_name))
            file_name = directory.get_next()

func _ready() -> void:
    animation_player.current_animation = "transition"
    animation_player.stop()

    for i in range(0, transition_sources.size()):
        var button = Button.new()
        button.text = "Transition %s" % i
        button.connect("pressed", self, "_on_Button_pressed", [i])
        button.rect_min_size.y = 50

        button.expand_icon = true
        button.icon = transition_sources[i]

        button_container.add_child(button)

func _on_Button_pressed(transition_index: int) -> void:
    _play_transition_with_texture(transition_sources[transition_index])


func _on_RandomNoiseButton_pressed() -> void:
    var noise = OpenSimplexNoise.new()
    noise.seed = randi()

    var image = noise.get_seamless_image(200)
    var texture = ImageTexture.new()
    texture.create_from_image(image)

    _play_transition_with_texture(texture)

func _play_transition_with_texture(texture) -> void:
    animation_player.stop()
    sprite.material.set_shader_param("source", texture)
    animation_player.play()
