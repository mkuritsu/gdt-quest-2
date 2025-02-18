extends Node2D

@export var NEXT_SCENE: PackedScene

func _ready() -> void:
	$Sprite2D.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_packed(NEXT_SCENE)
