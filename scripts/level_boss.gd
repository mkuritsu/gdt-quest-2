extends Node

func _ready() -> void:
	$ProgressBar.max_value = $Boss.health

func _process(_delta: float) -> void:
	$ProgressBar.value = $Boss.health
