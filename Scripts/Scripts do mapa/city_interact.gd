extends Button
@onready var cityButton = self
var man
@export var buttonType = 0
@onready var bookpg1 = get_node("/root/main/book/page1")
@onready var bookpg2 = get_node("/root/main/book/page2")
var has_worked = false

var shop_on = false

func _ready() -> void:
	man = self.get_parent()
	cityButton.pressed.connect(self._city_pressed)

func _process(_delta: float) -> void:
	if man.player.isTravel == true:
		self.visible = false
	else:
		self.visible = true

func _city_pressed() -> void:
	match buttonType:
		1:
			_open_shop()
		2:
			man.player.mess.add_text(str("\n",man.player.place.city_interact))
			_get_card()
		3:
			if man.player.money >= 40 && man.player.eng_state > 0:
				man.player.mess.add_text(str("\nA mechanic fixed your bike."))
				man.player.eng_state = 0
				man.player.temp = 0
				man.player.money -= 40
				man.player.day_counter += 1
				
			if man.player.money >= 40 && man.player.eng_state == 0:
				man.player.mess.add_text("\nYour bike looks damn fine.")
		4:
			if man.player.money >= 60 && man.player.bikeGas < 100:
				man.player.mess.add_text(str("\nYou refueled your bike."))
				man.player.bikeGas += 100-man.player.bikeGas
			
			if man.player.money >= 60 && man.player.bikeGas == 100:
				man.player.mess.add_text(str("\nYour tank is already full."))
		5:
			_open_book()
		6:
			_work()

func _open_shop():
	var items = get_children()
	var shop_anim = get_node("/root/main/city/shop/shop_anim")
	
	if shop_on == false:
		shop_anim.play("on")
		shop_on = true
	else: if shop_on == true:
		shop_anim.play("off")
		shop_on = false
	print(shop_on)

func _open_book():
	var book = get_node("/root/main/book")
	if book.visible == false:
		book.visible = true
	else:
		book.visible = false
	print(book.is_visible())
	
func _work():
	if man.player.place.has_worked == false:
		man.player.money += 50 
		man.player.day_counter += 1
		man.player.mess.add_text("\nYou worked a part-time job and rested on a nearby inn.")
		man.player.day_counter += 1
		man.player.place.has_worked = true
	else:
		man.player.mess.add_text("\nYou've already worked here. It's time to move on.")

func _get_card():
	var page1Array = bookpg1.get_children()
	var page2Array = bookpg2.get_children()
	
	for card in page1Array:
		if card.name == man.player.place.cityName:
			card.visible = true
			
	for card in page2Array:
		if card.name == man.player.place.cityName:
			card.visible = true
	
