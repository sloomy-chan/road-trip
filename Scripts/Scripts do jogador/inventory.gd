extends Node2D

@onready var inv = [$"1",$"2",$"3",$"4"]
@export var itemNmbr = 0

func _add_item():
	for slot in inv:
		if slot.itemID == 0:
			slot.itemID = itemNmbr
			return
		else:
			pass
