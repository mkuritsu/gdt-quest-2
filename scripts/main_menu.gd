extends Control


var first_level = preload("res://scenes/level01.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_F12):
		get_tree().change_scene_to_file("res://scenes/debug_level.tscn")
