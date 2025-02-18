extends Control


func _on_label_dialog_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/boss.tscn")
