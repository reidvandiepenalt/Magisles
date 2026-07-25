extends CharacterBody2D

@export var speed: float = 200.0
var can_swing := true

func _ready() -> void:
	return

func _physics_process(_delta) -> void:
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	if direction != Vector2.ZERO:
		$Tool.rotation = direction.angle()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("use_tool") && can_swing:
		swing_tool()

func swing_tool():
	var closest = null
	var closest_distance = INF
	
	for area in $Tool.get_overlapping_areas():
		var d = global_position.distance_squared_to(area.global_position)
		if d < closest_distance:
			closest_distance = d
			closest = area
	
	if closest:
		closest.damage(1)
