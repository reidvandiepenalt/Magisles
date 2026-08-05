extends Control

@onready var exp_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func update_exp_bar(xp: int, required_xp: int):
	exp_bar.max_value = required_xp
	exp_bar.value = xp
