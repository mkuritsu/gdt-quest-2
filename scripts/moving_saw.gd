extends RigidBody2D
class_name MovingSaw

var moving = false
const SPEED = 400
	
func start_moving(to: Vector2) -> void:
	moving = true
	$AnimatedSprite2D.play()
	var vec = (to - global_position).normalized()
	linear_velocity = vec * SPEED
	

func _physics_process(_delta: float) -> void:
	if moving:
		for body in get_colliding_bodies():
			if body is Player:
				body.kill()
		
	
