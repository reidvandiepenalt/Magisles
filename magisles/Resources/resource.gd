# Resource.gd
extends CollisionObject2D
class_name ResourceItem

@export var max_health := 3
@export var drop_scene: PackedScene
@export var drop_item: ItemData
@export var drop_amount := 1
@export var experience := 1

var health := 0

@onready var health_bar = $ResourceHealthBar

func _ready():
	health = max_health
	health_bar.ready_health(health, max_health)

func damage(player: PlayerScript, amount: int, ):
	health -= amount
	
	health_bar.set_health(health)
	
	if health <= 0:
		on_destroyed(player)

func on_destroyed(player: PlayerScript):
	GameEvents.resource_destroyed.emit(player, self)
	for i in drop_amount:
		var pickup = drop_scene.instantiate()
		pickup.item = drop_item
		pickup.global_position = global_position
		get_tree().current_scene.add_child(pickup)
		pickup.launch()
	
	queue_free()
