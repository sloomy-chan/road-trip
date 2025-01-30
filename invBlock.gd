extends Button

@onready var player = get_node("/root/main/PlayerManager")
@export var itemID = 0

func _ready() -> void:
	var invButton = self
	invButton.pressed.connect(self._use)

func _process(_delta: float) -> void:
	_add_name()

func _use():
	match itemID:
		0: 
			player.mess.add_text("\nNothing to use here.")
		1: 

			if player.bikeGas != 100:
				player.mess.add_text("\nYou refueled your tank.")
				if player.bikeGas > 90:
					player.bikeGas += (100-player.bikeGas)
				else:
					player.bikeGas += 10
			else: 
				player.mess.add_text("\nYour tank is already full!")
				return
	self.itemID = 0

func _add_name():
	match itemID:
		0:	self.set_text("Nada")
		1:	self.set_text("Gas")
