extends Node2D


func _on_new_game_pressed() -> void:
	self.get_tree().change_scene_to_file("res://Cenas/main.tscn")
