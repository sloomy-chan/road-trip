extends Button
@onready var player = get_node("/root/main/PlayerManager")
@onready var sprite = $"Sprite2D"
@export var itemID = 0
var itemName: String
var empty = false
@onready var man = self.get_parent()
@onready var audio_player = get_node("/root/main/inv/audio player")

func _ready() -> void:
	var invButton = self
	invButton.pressed.connect(self._use)

func _process(_delta: float) -> void:
	if itemID != 0:
		empty = false
	else:
		empty = true
	_add_name()
	_set_image()

func _use():
	match itemID:
		0: 
			audio_player.set_stream(man.null_audio)
			audio_player.play()
			player.mess.add_text("\nNothing to use here.")
			return
		1: 
			if player.bikeGas < 100:
				audio_player.set_stream(man.gas_audio)
				audio_player.play()
				player.mess.add_text("\nYou refueled your tank.")
				if player.bikeGas > 90:
					player.bikeGas += (100-player.bikeGas)
				else:
					player.bikeGas += 10
			else: 
				audio_player.set_stream(man.null_audio)
				audio_player.play()
				player.mess.add_text("\nYour tank is already full!")
				return
		2:
			audio_player.set_stream(man.banan_audio)
			audio_player.play()
			player.mess.add_text("\nYou ate the banana. Nothing happened.")
		3:
			if player.speed == 0 && player.temp > 9:
				player.temp -= 8
				audio_player.set_stream(man.coolant_audio)
				audio_player.play()
				player.mess.add_text("\nAdded some coolant to your bike's radiator.")
			else:
				audio_player.set_stream(man.null_audio)
				audio_player.play()
				player.mess.add_text("\nCan't use coolant right now.")
				return
		4:
			if player.eng_state > 26 && player.speed == 0:
				player.eng_state -= 25
				audio_player.set_stream(man.fixer_audio)
				audio_player.play()
				player.mess.add_text("\nFixed some issues on your engine.")
			else:
				audio_player.set_stream(man.null_audio)
				audio_player.play()
				player.mess.add_text("\nYou can't use that right now.")
				return
	self.itemID = 0

func _add_name():
	match itemID:
		0:	itemName = "Nada"
		1:	itemName = "Gas."
		2:	itemName = "A banana."
		3:	itemName = "Radiator coolant."
		4:	itemName = "An emergency kit."

@onready var mouse = get_node("/root/main/mouse")

func _on_mouse_entered() -> void:
	mouse.text.set_text(itemName)

func _on_mouse_exited() -> void:
	mouse.text.set_text("")
	
func _set_image():
	match itemID:
		0:	sprite.texture = null
		1:	sprite.texture = man.texture_gas
		2:	sprite.texture = man.texture_banan
		3:	sprite.texture = man.texture_cool
		4:	sprite.texture = man.texture_fixer
