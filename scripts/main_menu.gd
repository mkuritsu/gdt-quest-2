extends Control


var first_level = preload("res://scenes/level01.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
