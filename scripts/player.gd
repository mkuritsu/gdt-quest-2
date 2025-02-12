extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var ATTACK_DISTANCE = 200.0
@export var KNOCKBACK_VELOCITY = 500.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x += direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("attack"):
		var horizontal = Input.get_axis("move_left", "move_right")
		var vertical = Input.get_axis("up", "down")
		var attack_direction = Vector2.ZERO
		if absf(vertical) > absf(horizontal):
			attack_direction = Vector2(0, vertical)
		else:
			attack_direction = Vector2(horizontal, 0)
		attack_direction = attack_direction.normalized()
		var space_state = get_world_2d().direct_space_state
		var from = global_position
		var to = global_position + attack_direction * ATTACK_DISTANCE
		var query = PhysicsRayQueryParameters2D.create(from, to)
		query.collide_with_areas = true
		query.collide_with_bodies = true
		query.exclude = [self]
		var result = space_state.intersect_ray(query)
		if result:
			velocity += attack_direction * -KNOCKBACK_VELOCITY
			print(velocity)

	move_and_slide()
