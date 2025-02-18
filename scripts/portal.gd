extends Node2D
class_name Portal

signal portal_entered

func _ready() -> void:
	$Sprite2D.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		portal_entered.emit.call_deferred()
