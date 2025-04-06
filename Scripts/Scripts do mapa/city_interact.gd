extends Button
@onready var cityButton = self
var man
@export var buttonType = 0
@onready var bookpg1 = get_node("/root/main/book/page1")
@onready var bookpg2 = get_node("/root/main/book/page2")
var has_worked = false
var shop_on = false
@onready var audio_player = $"audio_player"

@export var shop_audio: AudioStream

func _ready() -> void:
	man = self.get_parent()
	cityButton.pressed.connect(self._city_pressed)

func _process(_delta: float) -> void:
	if man.player.isTravel == true:
		clicked_mechanic = 0
		self.visible = false
	else:
		self.visible = true

var clicked_mechanic = 0
func _city_pressed() -> void:
	match buttonType:
		1:
			_open_shop()
		2:
			man.player.mess.add_text(str("\n",man.player.place.city_interact))
			man.player.mess.add_text(str("\nA new postal card was added to your book."))
			_get_card()
		3:
			match clicked_mechanic:
				0:
					man.player.mess.add_text(str("\nHere's a breakdown of your bike's status. Your engine damage is at ", snappedf(man.player.eng_state, 1),"%, your front tire durability is at ", snappedf(man.player.tire_front_durability,1),"%, and your rear tire is at ", snappedf(man.player.tire_rear_durability,1),"%, Fixing all this will be 60 bucks."))
					clicked_mechanic += 1
				1:
					if man.player.money >= 60 && man.player.eng_state > 0 && man.player.tire_rear_durability != 100 or man.player.tire_front_durability != 100:
						man.player.mess.add_text(str("\nA mechanic fixed your bike."))
						self.audio_player.play()
						man.player.tire_front_durability = 100
						man.player.tire_rear_durability = 100
						man.player.eng_state = 0
						man.player.temp = 0
						man.player.money -= 40
						man.player.day_counter += 1
						clicked_mechanic -= 1
					else: if man.player.money >= 60 && man.player.eng_state == 0:
						man.player.mess.add_text("\nYour bike looks fine already.")
						clicked_mechanic -= 1
		4:
			if man.player.money < 60:
				man.player.mess.add_text(str("\nYou don't have enough money."))
				return
				
			if man.player.money >= 60 && man.player.bikeGas < 100:
				self.audio_player.play()
				man.player.mess.add_text(str("\nYou refueled your bike."))
				man.player.bikeGas += 100-man.player.bikeGas
				man.player.money -= 60
				return
			
			if man.player.money >= 60 && man.player.bikeGas == 100:
				man.player.mess.add_text(str("\nYour tank is already full."))
				return
		5:
			_open_book()
		6:
			_work()

func _open_shop():
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
	
