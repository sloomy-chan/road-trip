extends Button

var shopName: String
@export var item_type: int
@export var item_price: int
@onready var parent = self.get_parent()
@onready var inv = get_node("/root/main/inv")
@onready var player = get_node("/root/main/PlayerManager")
@onready var mouse = get_node("/root/main/mouse")
@onready var audio_player = get_node("/root/main/city/audio_player")

func _ready() -> void:
	_add_name()

func _on_pressed() -> void:
	audio_player.set_stream(parent.shop_audio)
	if inv.full == false:
		if player.money >= item_price:
			audio_player.play()
			player.money -= item_price
			inv.itemNmbr = item_type
			inv._add_item()
		else:
			player.mess.add_text("\nYou don't have enough money.")
	else:
		player.mess.add_text("\nYou don't have enough inventory space.")
	

func _add_name():
	match item_type:
		1:	shopName = str("A gallon of gas. \nCosts ", item_price, "bucks.")
		2:	shopName = str("A banana. \nCosts ", item_price, "bucks.")
		3:	shopName = str("Coolant. \nCosts ", item_price, "bucks.")
		4:	shopName = str("An emergency kit. \nCosts ", item_price, "bucks.")


func _on_mouse_entered() -> void:
	mouse.text.set_text(shopName)


func _on_mouse_exited() -> void:
	mouse.text.set_text("")
