extends AnimatedSprite2D
class_name Boss

const SAW = preload("res://objects/saw.tscn")
const DAMAGE_SOUND = preload("res://audio/boss_damage.wav")
const DEATH_SOUND = preload("res://audio/boss_death.mp3")
const ATTACK_COOLDOWN = 5

var rng = RandomNumberGenerator.new()
var health = 100
var acc_time = 0

func damage() -> void:
	if health > 0:
		health -= 1
		$AudioStreamPlayer2D.stream = DAMAGE_SOUND
		$AudioStreamPlayer2D.play()
		modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		modulate = Color.WHITE
		await get_tree().create_timer(0.1).timeout
		modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		modulate = Color.WHITE
		if health == 0:
			self.kill()
	
func kill() -> void:
	$AudioStreamPlayer2D.stream = DEATH_SOUND
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	get_tree().change_scene_to_file("res://scenes/final.tscn")
	
func attack() -> void:
	var attack_type = rng.randi_range(0, 0)
	print('ATTACK', attack_type)
	if attack_type == 0:
		var saw_instance = SAW.instantiate()
		print('Saw create')
		await get_tree().create_timer(1).timeout
		print('Saw destroy')
		saw_instance.queue_free()
	pass

func _process(delta: float) -> void:
	if health > 0:
		acc_time += delta
		if acc_time >= ATTACK_COOLDOWN:
			acc_time = 0
			self.attack()
