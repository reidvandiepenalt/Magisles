extends StaticBody2D
class_name Building

@export var crafting_recipes: Array[CraftingRecipeData]

var current_recipe: CraftingRecipeData
var progress := 0.0
var craft_time : float
var crafting := false
var inventory: Inventory

signal crafting_progress(progress)
signal crafting_finished()

func _process(delta):
	if !crafting:
		return
	
	progress -= delta
	
	if progress <= 0:
		inventory.add_item(
			current_recipe.output,
			current_recipe.output_amount
		)
		
		crafting = false
		crafting_finished.emit()
	else:
		crafting_progress.emit(1 - progress / craft_time)

func craft(crafting_recipe: CraftingRecipeData):
	if crafting:
		return
	
	if !inventory.has_items(crafting_recipe.recipe):
		return
	
	inventory.consume(crafting_recipe.recipe)
	
	current_recipe = crafting_recipe
	craft_time = current_recipe.crafting_time
	progress = craft_time
	crafting = true

func interact(player: PlayerScript):
	var crafting_menu = player.find_child("CraftingMenu")
	if !inventory:
		inventory = player.find_child("Inventory")
	crafting_menu.set_building_and_open(self)
