extends Button

@export var places_connected: Array
@export var cityName: String
@export var city_interact: String

@onready var map_list = []
@onready var player = get_node("/root/main/PlayerManager")
@onready var parent = self.get_parent()

var has_worked = false
var mapButton = self
@export var isConnected = false


func _ready() -> void:
	map_list = parent.get_children()
	mapButton.pressed.connect(self._map_selected)
	for places in places_connected:
		places = get_node(places)
	self.text = ""
	
func _process(_delta: float) -> void:
	if isConnected == true:
		self.self_modulate = Color(1,1,1,1)
	else:
		self.self_modulate = Color(1,1,1,0.5)
		
func _map_selected():
	var choose_ride = randi_range(1,3)
	player.place = self
	player.place.has_worked = false
	if player.speed <= 0 && isConnected == true && player.isTravel == false:
		player.startPos = player.global_position
		player.isTravel = true
		match choose_ride:
			1:
				player.next_state = player.riding_sunset
			2:
				player.next_state = player.riding_noon
			3:
				player.next_state = player.riding_night
		player.transitioner.play("fade_in")
		player.nextPos = self.global_position
		player.city.nextCity_name = cityName
	else:
		player.mess.add_text("\nYou can't go there right now.")
	
func _get_places():
	for map in map_list:
		map.isConnected = false
	for places in places_connected:
		var placesNode = get_node(places)
		placesNode.isConnected = true

@onready var mouse = get_node("/root/main/mouse")

func _on_mouse_entered() -> void:
	mouse.text.set_text(cityName)


func _on_mouse_exited() -> void:
	mouse.text.set_text("")
