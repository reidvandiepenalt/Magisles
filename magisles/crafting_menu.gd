extends Control

var building: Building

@onready var ui_manager: UIManager = get_parent()
@onready var grid: GridContainer = $"PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/CenterContainer/GridContainer"

@export var card_scene: PackedScene

func set_building_and_open(target: Building):
	building = target
	populate()
	ui_manager.open_menu(self)

func populate():
	for child in grid.get_children():
		child.queue_free()
	
	for recipe in building.crafting_recipes:
		var card = card_scene.instantiate()
		grid.add_child(card)
		
		card.setup(recipe, building)
