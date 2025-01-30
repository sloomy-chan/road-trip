extends Node2D

@onready var inv = [$"1",$"2"]

func _ready():
	_add_item()

func _add_item():
	inv.insert(0, 1)
