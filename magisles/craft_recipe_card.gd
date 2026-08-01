extends PanelContainer
class_name CraftRecipeCard

var building_ref: Building
var recipe_data: CraftingRecipeData

@export var ingredient_row_scene: PackedScene

@onready var name_label: Label = $"MarginContainer/VBoxContainer/Label"
@onready var ingredient_card_container: VBoxContainer = $"MarginContainer/VBoxContainer/VBoxContainer"


func setup(recipe: CraftingRecipeData, building: Building):
	recipe_data = recipe
	building_ref = building

	name_label.text = recipe.output.item_name

	for ingredient in recipe_data.recipe.ingredients:
		var row = ingredient_row_scene.instantiate()
		ingredient_card_container.add_child(row)
		row.setup(ingredient, building.inventory)
		


func _on_button_pressed():
	building_ref.craft(recipe_data)
