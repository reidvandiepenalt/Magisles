extends CharacterBody2D
class_name PlayerScript

@export var speed: float = 200.0
@onready var inventory: Inventory = $Inventory
@onready var input_state: InputState = $InputState

@export var swing_cooldown := 0.25
var can_swing := true

func _ready() -> void:
	return

func _physics_process(_delta) -> void:
	if input_state.gameplay_enabled():
		handle_movement(_delta)

func handle_movement(_delta: float) -> void:
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	if direction != Vector2.ZERO:
		$Tool.rotation = direction.angle()

func _input(event):
	if !input_state.gameplay_enabled():
		return;
	
	if event.is_action_pressed("use_tool") && can_swing:
		swing_tool()
	elif event.is_action_pressed("interact"):
		use_interact()

func use_interact():
	var closest = null
	var closest_distance = INF
	
	for area in $InteractionArea.get_overlapping_areas():
		var d = global_position.distance_squared_to(area.global_position)
		if d < closest_distance:
			closest_distance = d
			closest = area
	
	if closest:
		closest.interact(self)


func swing_tool():
	can_swing = false
	var closest = null
	var closest_distance = INF
	
	for area in $Tool.get_overlapping_areas():
		var d = global_position.distance_squared_to(area.global_position)
		if d < closest_distance:
			closest_distance = d
			closest = area
	
	if closest:
		closest.damage(self, 1)
	
	await get_tree().create_timer(swing_cooldown).timeout
	
	can_swing = true
