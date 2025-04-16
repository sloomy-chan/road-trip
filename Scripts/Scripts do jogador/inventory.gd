extends Node2D

@onready var inv = [$"1",$"2",$"3",$"4"]
var full = false
@export var itemNmbr = 0
@export var texture_banan: Texture2D
@export var texture_cool: Texture2D
@export var texture_gas: Texture2D
@export var texture_fixer: Texture2D

@export var null_audio: AudioStream
@export var banan_audio: AudioStream
@export var gas_audio: AudioStream
@export var coolant_audio: AudioStream
@export var fixer_audio: AudioStream

func _process(_delta: float) -> void:
	for slot in inv:
		if slot.itemID != 0:
			full = true
		else:
			full = false
			
func _add_item():
	for slot in inv:
		if slot.itemID == 0:
			slot.itemID = itemNmbr
			return
		else:
			pass
