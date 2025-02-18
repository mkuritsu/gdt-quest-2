extends CharacterBody2D
class_name Player

const SLASH = preload("res://objects/slash.tscn")
const DEATH_SOUND = preload("res://audio/oof.mp3")
const ATTACK_SOUND = preload("res://audio/sword_attack.wav")

@export var SPEED = 250.0
@export var JUMP_VELOCITY = -320.0
@export var ATTACK_DISTANCE = 110.0
@export var KNOCKBACK_VELOCITY = -250.0
@export var AIR_FRICTION = 1.0

var current_slash = null
var is_dying = false

func kill() -> void:
	if !is_dying:
		is_dying = true
		$AudioStreamPlayer2D.stream = DEATH_SOUND
		$AudioStreamPlayer2D.play()

func slash() -> void:
	if is_instance_valid(current_slash):
		return
	var slash_anim = SLASH.instantiate()
	slash_anim.rotation = PI
	slash_anim.play()
	current_slash = slash_anim
	add_child(slash_anim)
	var areas = $Area2D.get_overlapping_areas()
	var bodies = $Area2D.get_overlapping_bodies()
	if len(areas) > 0 || len(bodies) > 1:
		velocity.y = KNOCKBACK_VELOCITY
		$AudioStreamPlayer2D.stream = ATTACK_SOUND
		$AudioStreamPlayer2D.play()
		for area in areas:
			if area.get_parent() is Boss:
				area.get_parent().damage()

func _process(_delta: float) -> void:
	if is_dying:
		$AnimatedSprite2D.play("death")
		return
	if is_instance_valid(current_slash):
		$AnimatedSprite2D.play("attack")
		return
	if velocity.x == 0:
		$AnimatedSprite2D.play("idle")
		return
	$AnimatedSprite2D.play("walk")
	$AnimatedSprite2D.flip_h = velocity.x < 0
		
func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity.x *= AIR_FRICTION
	if is_dying:
		velocity.x = 0
	else:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if Input.is_action_just_pressed("attack"):
			self.slash()
			$AnimatedSprite2D.play("attack")
	move_and_slide()


func _on_animated_sprite_2d_animation_looped() -> void:
	if is_dying:
		get_tree().reload_current_scene()
