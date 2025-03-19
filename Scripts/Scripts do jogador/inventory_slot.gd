extends Button

@onready var player = get_node("/root/main/PlayerManager")
@export var itemID = 0
var itemName: String
var empty = false

func _ready() -> void:
	var invButton = self
	invButton.pressed.connect(self._use)

func _process(_delta: float) -> void:
	if itemID != 0:
		empty = false
	else:
		empty = true
	_add_name()

func _use():
	match itemID:
		0: 
			player.mess.add_text("\nNothing to use here.")
			return
		1: 
			if player.bikeGas < 100:
				player.mess.add_text("\nYou refueled your tank.")
				if player.bikeGas > 90:
					player.bikeGas += (100-player.bikeGas)
				else:
					player.bikeGas += 10
			else: 
				player.mess.add_text("\nYour tank is already full!")
				return
		_:
			player.mess.add_text("\nYou ate something.")
	self.itemID = 0

func _add_name():
	match itemID:
		0:	itemName = "Nada"
		1:	itemName = "Gas"
		2:	itemName = "A banana"
		3:	itemName = "An apple"
		4:	itemName = "A sandwich"

@onready var mouse = get_node("/root/main/mouse")

func _on_mouse_entered() -> void:
	mouse.text.set_text(itemName)


func _on_mouse_exited() -> void:
	mouse.text.set_text("")
