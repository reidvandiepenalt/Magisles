extends PanelContainer

@export var ingredient_row_scene: PackedScene

@onready var name_label = $MarginContainer/VBoxContainer/Name
@onready var icon = $MarginContainer/VBoxContainer/Icon
@onready var costs = $MarginContainer/VBoxContainer/CostContainer

var building: BuildingData

signal selected(building: BuildingData)

var can_build := false

func _gui_input(event):
	if !visible:
		return
	
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed \
	and can_build:
		selected.emit(building)

func refresh(inventory: Inventory):
	can_build = inventory.has_items(building.recipe)
	
	if can_build:
		modulate = Color.WHITE
	else:
		modulate = Color(0.5, 0.5, 0.5)
	
	# Also refresh each ingredient row
	for row in costs.get_children():
		row.refresh(inventory)

func setup(building_data: BuildingData, inventory: Inventory):
	building = building_data
	can_build = inventory.has_items(building.recipe)
	
	name_label.text = building.display_name
	icon.texture = building.icon
	
	for child in costs.get_children():
		child.queue_free()
	
	for ingredient in building.recipe.ingredients:
		var row = ingredient_row_scene.instantiate()
		costs.add_child(row)
		row.setup(ingredient, inventory)
	
	modulate = Color.WHITE if can_build else Color(0.6,0.6,0.6)
