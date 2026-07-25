extends Node

var occupied: Dictionary = {}
var grass_tiles: Array[Vector2i] = []
@export var ground_tilemap: TileMapLayer
@export var resources: Node
var spawn_timer = 0.0
var picked_spawn_time: float
@export var min_spawn_time = 15.0
@export var max_spawn_time = 30.0
@export var spawn_table: Array[SpawnEntry]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	picked_spawn_time = randf_range(min_spawn_time, max_spawn_time)
	
	var used_rect = ground_tilemap.get_used_rect()
	for x in range(used_rect.position.x, used_rect.end.x):
		for y in range(used_rect.position.y, used_rect.end.y):
			var cell = Vector2i(x, y)
			if is_grass(cell):
				grass_tiles.append(cell)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (spawn_timer > picked_spawn_time):
		#Create a weighted table and pick random resource from table
		spawn_resource()
		
		picked_spawn_time = randf_range(min_spawn_time, max_spawn_time)
		spawn_timer = 0.0
	else:
		spawn_timer += delta

func spawn_resource():
	var cell = grass_tiles.pick_random()
	
	if occupied.has(cell):
		return
	
	var resource = get_random_resource().instantiate()
	resource.position = ground_tilemap.map_to_local(cell)
	resources.add_child(resource)
	occupied[cell] = resource

func get_random_resource() -> PackedScene:
	var total_weight := 0
	
	for entry in spawn_table:
		total_weight += entry.weight
	
	var roll = randi_range(1, total_weight)
	
	for entry in spawn_table:
		roll -= entry.weight
		if roll <= 0:
			return entry.scene
	
	return null

func is_grass(cell: Vector2i) -> bool:
	var tile_data = ground_tilemap.get_cell_tile_data(cell)

	if tile_data == null:
		return false
		
	return tile_data.get_custom_data("terrain") == "grass"
