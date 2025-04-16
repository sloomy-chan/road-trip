extends Node2D
var save_man = SaveManager

func _on_resume_pressed() -> void:
	self.visible = false


func _on_save_pressed() -> void:
	save_man._save_game()


func _on_load_pressed() -> void:
	save_man._load_game()


func _on_quit_pressed() -> void:
	get_tree().quit()
