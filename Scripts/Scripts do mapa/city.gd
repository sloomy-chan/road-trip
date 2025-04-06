extends Node2D
@onready var player = get_node("/root/main/PlayerManager")
@onready var inv = get_node("/root/main/inv")
var currCity_name:String
var nextCity_name:String
@onready var audio_player = get_node("/root/main/city/audio_player")

@export var mechanic_audio: AudioStream
@export var gas_audio: AudioStream

func _process(_delta: float) -> void:
	_name_picker()

func _name_picker():
	if player.A1 == player.B1:
		currCity_name = nextCity_name
