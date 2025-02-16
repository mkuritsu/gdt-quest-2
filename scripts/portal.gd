extends Node2D

@export var NEXT_SCENE: PackedScene

func _on_area_2d_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_packed(NEXT_SCENE)
