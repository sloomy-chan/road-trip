extends Button

@onready var player = get_node("/root/main/PlayerManager")
var mapButton = self
@export var mapID = 0

func _ready() -> void:
	mapButton.pressed.connect(self._map_selected)

func _process(_delta: float) -> void:
	if player.timer <= 0.0:
		player.currPos = player.nextPos

func _map_selected():
	if player.isTravel == false && player.currPos != mapID:
		player.nextPos = mapID
		match mapID:
			1:
				player.timer += 100
			2: 
				player.timer += 100
			3:
				player.timer += 300
	if player.isTravel == false:
		player.mess.add_text(str("\n You are currently headed to ", player.nextPos))
	else:
		player.mess.add_text(str("\n You already have a destination."))
