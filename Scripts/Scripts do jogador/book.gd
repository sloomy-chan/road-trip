extends Node2D

var postal_cards = []

func _ready() -> void:
	var map = get_node("/root/main/map").get_tree()
	var size = map.get_nodes_in_group("place")
	postal_cards.resize(size.size())
	print(str(postal_cards))
	print(str(size))

func _add_card():
	pass
