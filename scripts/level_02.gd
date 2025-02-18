extends Node

func _on_portal_portal_entered() -> void:
	get_tree().change_scene_to_file("res://scenes/level03.tscn")
