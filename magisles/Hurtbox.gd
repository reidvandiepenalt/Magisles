extends Area2D
class_name Hurtbox

func damage(player: PlayerScript, amount: int):
	get_parent().damage(player, amount)
