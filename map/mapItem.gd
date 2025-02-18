extends Button

#@export var connects_To = [$"1"]
@onready var player = get_node("/root/main/PlayerManager")
@export var cityName: String
var mapButton = self
var isConnected = true


func _ready() -> void:
	mapButton.pressed.connect(self._map_selected)
	cityName = self.text
	
func _process(delta: float) -> void:
	pass
	#for i in connects_To:
	#	if i != null:
	#		i.isConnected = true
	#	else:
	#		i.isConnected = false

func _map_selected():
	if player.speed <= 0 && isConnected == true:
		player.startPos = player.global_position
		player.isTravel = true
		player.nextPos = self.global_position
		player.city.nextCity_name = cityName
	
