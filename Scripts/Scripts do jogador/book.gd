extends Node2D

var postal_cards = []
@onready var player = get_node("/root/main/PlayerManager")


func _ready() -> void:
	var map = get_node("/root/main/map").get_tree()
	var size = map.get_nodes_in_group("place")
	postal_cards.resize(size.size())
	print(str(postal_cards))
	print(str(size))

func _process(_delta: float) -> void:
	var sprites = self.get_children()
	for a in sprites:
		for i in postal_cards:
			if i == null:
					a.visible = false
			else:
					a.visible = true

func _add_card():
	for cards in postal_cards:
		if postal_cards.has(player.place.cityName):
			return
		else:
			postal_cards.insert(0,str(player.place.cityName))
			print(postal_cards)
	
