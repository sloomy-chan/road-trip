extends Button

@onready var loc1 = self
@export var loc2: Node
@onready var player = get_node("/root/main/PlayerManager")
var mapButton = self
@export var mapID = 0

func _ready() -> void:
	mapButton.pressed.connect(self._map_selected)

func _process(_delta: float) -> void:
	if player.timer <= 0.0 && player.isTravel == false:
		player.currPos = player.nextPos
	
	

func _map_selected():
	if player.isTravel == false && player.currPos != mapID:
		player.nextPos = mapID
		match mapID:
			1:
				match player.currPos:
					0:
						player.timer += 120
					2:
						player.timer += 790
					3:
						player.timer += 350
			2: 
				match player.currPos:
					0:
						player.timer += 120
					1:
						player.timer += 790
					3:
						player.timer += 350
			3:
				match player.currPos:
					0:
						player.timer += 120
					1:
						player.timer += 350
					2:
						player.timer += 280
	if player.isTravel == false:
		player.mess.add_text(str("\nYou are currently headed to ", player.city.nextCity_name))
	else:
		player.mess.add_text(str("\nYou already have a destination."))
	
func _draw():
	draw_line(loc1.global_position, loc2.global_position, Color.GREEN, 2.0)
	
