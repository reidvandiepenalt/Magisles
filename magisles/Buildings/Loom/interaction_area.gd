extends Area2D
class_name InteractionArea


func interact(player: PlayerScript):
	get_parent().interact(player)
