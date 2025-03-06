extends Button

@export var places_connected: Array
@export var cityName: String

@onready var map_list = []
@onready var player = get_node("/root/main/PlayerManager")

var mapButton = self
var isConnected = false
var cityPath: Node


func _ready() -> void:
	var parent = self.get_parent()
	map_list = parent.get_children()
	mapButton.pressed.connect(self._map_selected)
	cityName = self.text
	isConnected = true
	
func _process(_delta: float) -> void:
	if isConnected == true:
		self.scale = Vector2(2,2)
	else:
		self.scale = Vector2(1,1)
		
func _map_selected():
	if player.speed <= 0 && isConnected == true:
		player.startPos = player.global_position
		player.isTravel = true
		player.nextPos = self.global_position
		player.city.nextCity_name = cityName
		player.place = self
	else:
		player.mess.add_text("\nYou can't go there right now.")
	
func _get_places():
	for items in places_connected:
		for maps in map_list:
			var itemNode = get_node(items)
			if maps == itemNode:
				maps.isConnected = true
			else:
				maps.isConnected = false
		print(map_list)
