# Resource.gd
extends CollisionObject2D

@export var max_health := 3

var health := 0

func _ready():
	health = max_health

func damage(amount: int):
	health -= amount

	if health <= 0:
		on_destroyed()

func on_destroyed():
	queue_free()
