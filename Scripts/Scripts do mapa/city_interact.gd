extends Button
@onready var cityButton = self
var man
@export var buttonType = 0

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
			if man.player.money > 40:
				man.player.mess.add_text(str("\nA mechanic fixed your bike."))
				man.player.eng_state = 0
				man.player.temp = 0
			else:
				man.player.mess.add_text("\nYou don't have enough money.")
		4:
			man.player.mess.add_text(str("\nYou refueled your bike."))
			print("gas")
			man.player.bikeGas += 100-man.player.bikeGas

func _open_shop():
	var items = get_children()
	for i in items:
		if i.is_in_group("shop_item"):
			if i.visible == true:
				i.visible = false
			else:
				i.visible = true
