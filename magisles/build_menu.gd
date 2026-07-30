extends Control
class_name BuildMenu

@onready var grid = $CenterContainer/PanelContainer/MarginContainer/ScrollContainer/GridContainer
@onready var inventory = $"../../Inventory"

@export var card_scene: PackedScene

@export var recipe_book: RecipeBook

signal building_selected(building: BuildingData)

func _ready():
	inventory.inventory_changed.connect(refresh)

func refresh():
	for card in grid.get_children():
		card.refresh(inventory)

func open():
	populate()

func populate():
	for child in grid.get_children():
		child.queue_free()
	
	print(recipe_book.building_recipes)
	for building in recipe_book.building_recipes:
		var card = card_scene.instantiate()
		grid.add_child(card)
		card.setup(building, inventory)
		card.selected.connect(_on_card_selected)

func _on_card_selected(building: BuildingData):
	visible = false
	building_selected.emit(building)
