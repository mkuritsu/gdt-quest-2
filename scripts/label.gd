extends Label

@export var LETTER_TIME = 0.05

const TEXTS = [
	"Congratulations on completing your first baby steps :D", 
	"Now to your next challenge",
	"KILL THE BIG BOSS"
]
const BOSS_SCENE = preload("res://scenes/boss.tscn")

var index = 0
var acc_time = 0.0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if text == TEXTS[index]:
			index += 1
			text = ""
		else:
			text = TEXTS[index]
	if index == TEXTS.size():
		get_tree().change_scene_to_packed(BOSS_SCENE)
		return
	if text != TEXTS[index]:
		acc_time += delta
		if acc_time >= LETTER_TIME:
			acc_time = 0
			text += TEXTS[index][text.length()]
