extends Button
@onready var cityButton = self
var man
@export var buttonType = 0
var has_worked = false

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
			man.player.mess.add_text(str("\nThis is the city of ", man.currCity_name))
			print("city")
		3:
			if man.player.money >= 40 && man.player.eng_state > 0:
				man.player.mess.add_text(str("\nA mechanic fixed your bike."))
				man.player.eng_state = 0
				man.player.temp = 0
				man.player.money -= 40
				
			if man.player.money >= 40 && man.player.eng_state == 0:
				man.player.mess.add_text("\nYour bike looks damn fine.")
		4:
			if man.player.money >= 60 && man.player.bikeGas < 100:
				man.player.mess.add_text(str("\nYou refueled your bike."))
				print("gas")
				man.player.bikeGas += 100-man.player.bikeGas
			
			if man.player.money >= 60 && man.player.bikeGas == 100:
				man.player.mess.add_text(str("\nYour tank is already full."))
		5:
			_open_book()
		6:
			_work()

func _open_shop():
	var items = get_children()
	for i in items:
		if i.is_in_group("shop_item"):
			if i.visible == true:
				i.visible = false
			else:
				i.visible = true

func _open_book():
	var book = get_node("/root/main/book")
	if book.visible == false:
		book.visible = true
	else:
		book.visible = false
	print(book.is_visible())
	
func _work():
	if has_worked == false:
		man.player.money += 50 
		man.player.day_counter += 1
		man.player.mess.add_text("\nYou worked a part-time job and rested on a nearby inn.")
		has_worked = true
	else:
		man.player.mess.add_text("\nYou've already worked here. It's time to move on.")
	
