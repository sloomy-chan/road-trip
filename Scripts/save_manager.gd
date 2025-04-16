extends Node2D
@onready var player = get_node("/root/main/PlayerManager")
@onready var inventory = get_node("/root/main/inv")
@onready var bookPg2 = get_node("/root/main/book/page2")
@onready var bookPg1 = get_node("/root/main/book/page1")
@onready var map = get_node("/root/main/map")

func _save_game():
	var save_file = FileAccess.open("user://save_file.save", FileAccess.WRITE)
	save_file.store_float(player.eng_state)
	save_file.store_float(player.money)
	save_file.store_float(player.day_counter)
	save_file.store_var(player.isTravel)
	save_file.store_float(player.bikeGas)
	save_file.store_float(player.tire_rear_durability)
	save_file.store_float(player.tire_front_durability)
	save_file.store_float(player.global_position.x)
	save_file.store_float(player.global_position.y)
	var invSlots = inventory.get_children()
	for slots in invSlots:
		if slots.is_in_group("inv"):
			save_file.store_float(slots.itemID)
		else:
			pass
		
	var cardspg1 = bookPg1.get_children()
	var cardspg2 = bookPg2.get_children()
	for cards in cardspg1:
		save_file.store_var(cards.visible)
	for cards in cardspg2:
		save_file.store_var(cards.visible)
	#TODO: Não funciona com os mapas.
	#var mapArray = map.get_children()
	#for places in mapArray:
#		save_file.store_var(places.has_interacted)
#		save_file.store_var(places.is_connected)

func _load_game():
	var save_file = FileAccess.open("user://save_file.save", FileAccess.READ)
	player.eng_state = save_file.get_float()
	player.money = save_file.get_float()
	player.day_counter = save_file.get_float()
	player.bikeGas = save_file.get_float()
	player.tire_rear_durability = save_file.get_float()
	player.tire_front_durability = save_file.get_float()
	player.global_position.x = save_file.get_float()
	player.global_position.y = save_file.get_float()
	player.isTravel = save_file.get_var()
	var cardspg1 = bookPg1.get_children()
	var cardspg2 = bookPg2.get_children()
	for cards in cardspg1:
		cards.visible = save_file.get_var()
	for cards in cardspg2:
		cards.visible = save_file.get_var()
#	var mapArray = map.get_children()
	#for places in mapArray:
		#places.has_interacted = save_file.get_var()
	#	places.is_connected = save_file.get_var()
	
	var invSlots = inventory.get_children()
	for slots in invSlots:
		if slots.is_in_group("inv"):
			slots.itemID = save_file.get_float()
		else:
			pass
