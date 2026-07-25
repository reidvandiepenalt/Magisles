extends Area2D

func damage(amount: int):
	get_parent().damage(amount)
