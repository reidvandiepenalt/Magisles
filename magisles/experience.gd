extends Node
class_name Experience

signal xp_changed(current: int, required: int)
signal level_changed_by(amount: int)

var level := 1
var xp := 0

@export var base_xp := 25
@export var growth := 1.4

func _ready():
	GameEvents.resource_destroyed.connect(_on_resource_destroyed)

func required_xp() -> int:
	return roundi(base_xp * pow(growth, level - 1))

func _on_resource_destroyed(player: PlayerScript, resource: ResourceItem):
	if player != get_parent():
		return
	
	add_xp(resource.experience)

func add_xp(amount: int):
	xp += amount
	while xp >= required_xp():
		xp -= required_xp()
		level += 1
		level_changed_by.emit(amount)
	
	xp_changed.emit(xp, required_xp())
