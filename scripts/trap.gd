extends AnimatedSprite2D


func _process(_delta: float) -> void:
	for body in $Area2D.get_overlapping_bodies():
		if body is Player:
			body.kill()
