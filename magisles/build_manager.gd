extends Node2D
class_name BuildManager

var selected_building: BuildingData
var preview: Node2D

@export var build_menu: BuildMenu
@export var inventory: Inventory
@export var tilemap: TileMapLayer

var can_place := true

signal building_placed(menu: Control)

func begin_placing(building: BuildingData):
	selected_building = building
	preview = building.scene.instantiate()
	preview.modulate.a = 0.5
	_disable_collisions(preview)
	add_child(preview)

func _disable_collisions(node: Node):
	if node is CollisionShape2D:
		node.disabled = true
	
	for child in node.get_children():
		_disable_collisions(child)

func _ready():
	build_menu.building_selected.connect(_on_building_selected)

func _on_building_selected(building: BuildingData):
	begin_placing(building)

func _process(_delta):
	if preview == null:
		return
	
	can_place = check_if_valid()
	if can_place:
		preview.modulate = Color(1, 1, 1, 0.5)
	else:
		preview.modulate = Color(1, 0.3, 0.3, 0.5)
	var mouse = get_global_mouse_position()
	
	var cell = tilemap.local_to_map(tilemap.to_local(mouse))
	
	preview.global_position = tilemap.to_global(
		tilemap.map_to_local(cell)
	)

func check_if_valid():
	if !inventory.has_items(selected_building.recipe):
		return false
	
	return true

func place_building():
	if !can_place:
		return
	
	inventory.consume(selected_building.recipe)
	var building: Building = selected_building.scene.instantiate()
	building.global_position = preview.global_position
	building.inventory = inventory
	$"../Buildings".add_child(building)
	preview.queue_free()
	preview = null
	selected_building = null
	building_placed.emit(build_menu)
	

func _input(event):
	if preview == null:
		return
	
	if event.is_action_pressed("use_tool"):
		place_building()
	elif event.is_action_pressed("ui_cancel"):
		cancel_building()

func cancel_building():
	if preview:
		preview.queue_free()
	
	preview = null
	selected_building = null
