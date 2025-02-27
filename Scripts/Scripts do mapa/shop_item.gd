extends Button

@export var item_type: int
@export var item_price: int
@onready var parent = self.get_parent()
@onready var inv = get_node("/root/main/inv")
@onready var player = get_node("/root/main/PlayerManager")

func _ready() -> void:
	_add_name()

func _on_pressed() -> void:
	if player.money >= item_price:
		player.money -= item_price
		inv.itemNmbr = item_type
		inv._add_item()
	else:
		print("Broke ass idiot")

func _add_name():
	match item_type:
		1:	self.set_text("Gas")
		2:	self.set_text("A banana")
		3:	self.set_text("An apple")
		4:	self.set_text("A sandwich")
