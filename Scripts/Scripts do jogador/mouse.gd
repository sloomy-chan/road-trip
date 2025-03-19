extends Node2D

var mouse
@onready var text = $"text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mouse = get_viewport().get_mouse_position()
	self.global_position = mouse
