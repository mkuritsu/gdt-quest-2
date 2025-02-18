extends Label
class_name TextDialog

signal dialog_finished

@export var LETTER_TIME = 0.05
@export var TEXTS: Array
@export var NEXT_SCENE: PackedScene

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
		dialog_finished.emit()
		return
	if text != TEXTS[index]:
		acc_time += delta
		if acc_time >= LETTER_TIME:
			acc_time = 0
			text += TEXTS[index][text.length()]
