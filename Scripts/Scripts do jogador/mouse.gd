extends Node2D

var mouse
@onready var text = $"text"
@onready var audio = $"AudioStreamPlayer2D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mouse = get_viewport().get_mouse_position()
	self.global_position = mouse

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			audio.play()
