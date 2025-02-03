extends Node2D
@onready var player = get_node("/root/main/PlayerManager")
@onready var inv = get_node("/root/main/inv")
var currCity_name:String
var nextCity_name:String

func _process(_delta: float) -> void:
	_name_picker()

func _name_picker():
	match player.currPos:
		0:
			currCity_name = "Home."
		1:
			currCity_name = "Milho Verde"
		2:
			currCity_name = "Caralheiros"
		3:
			currCity_name = "Nova Jordan"
	match player.nextPos:
		1:
			nextCity_name = "Milho verde"
		2:
			nextCity_name = "Caralheiros"
		3:
			nextCity_name = "Nova Jordan"
