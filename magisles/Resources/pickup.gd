extends Area2D

@export var item: ItemData
@export var amount := 1

var velocity = Vector2.ZERO

func _ready():
	body_entered.connect(_on_body_entered)

func launch():
	velocity = Vector2.RIGHT.rotated(randf() * TAU) * randf_range(40, 80)

func _physics_process(delta):
	global_position += velocity * delta
	velocity = velocity.move_toward(Vector2.ZERO, 300 * delta)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.inventory.add_item(item, amount)
		queue_free()
