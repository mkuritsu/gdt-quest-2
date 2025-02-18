extends CharacterBody2D
class_name Player


const SLASH = preload("res://objects/slash.tscn")

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var ATTACK_DISTANCE = 110.0
@export var KNOCKBACK_VELOCITY = -250.0

var current_slash = null

func slash() -> void:
	if is_instance_valid(current_slash):
		return
	var attack_direction = Vector2(0, 1)
	var space_state = get_world_2d().direct_space_state
	var from = global_position
	var to = global_position + attack_direction * ATTACK_DISTANCE
	var query = PhysicsRayQueryParameters2D.create(from, to)
	query.collide_with_areas = true
	query.collide_with_bodies = true
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	var slash_anim = SLASH.instantiate()
	slash_anim.rotation = PI
	slash_anim.play()
	current_slash = slash_anim
	add_child(slash_anim)
	if result and velocity.y >= 0:
		velocity.y = KNOCKBACK_VELOCITY
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("attack"):
		self.slash()
	move_and_slide()
