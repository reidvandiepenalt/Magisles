extends Node2D
class_name ResourceHealthBar

@onready var progress = $TextureProgressBar
@onready var hide_timer = $Timer

func set_health(health: int):
	progress.value = health
	visible = true
	hide_timer.start()

func ready_health(health: int, max_health: int):
	progress.max_value = max_health
	progress.value = health
	visible = false

func _on_hide_timer_timeout():
	visible = false
