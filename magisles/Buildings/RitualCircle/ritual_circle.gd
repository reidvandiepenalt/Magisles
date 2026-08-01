extends Building
class_name RitualCircle

@export var plinths: Array[Plinth]
var player_ref: PlayerScript

func _process(delta):
	if !crafting:
		if plinths_has_items():
			crafting = true
	
	progress -= delta
	
	if progress <= 0:
		inventory.add_item(
			current_recipe.output,
			current_recipe.output_amount
		)
		
		plinths_consume_items()
		
		crafting = false
		crafting_finished.emit()
	else:
		crafting_progress.emit(1 - progress / craft_time)

func craft(crafting_recipe: CraftingRecipeData):
	if crafting:
		return
	
	if current_recipe && player_ref:
		clear_plinth_items(player_ref)
	
	set_plinth_items(crafting_recipe)
	
	current_recipe = crafting_recipe
	craft_time = current_recipe.crafting_time
	progress = craft_time

func interact(player: PlayerScript):
	player_ref = player
	var crafting_menu = player.find_child("CraftingMenu")
	if !inventory:
		inventory = player.find_child("Inventory")
	crafting_menu.set_building_and_open(self)

func set_plinth_items(crafting_recipe: CraftingRecipeData):
	var i = 0
	for recipe_item in crafting_recipe.recipe.ingredients:
		plinths[i].recipe_item = recipe_item
		i += 1

func clear_plinth_items(player: PlayerScript):
	for plinth in plinths:
		plinth.clear_item(player)

func plinths_has_items():
	if !current_recipe:
		return false
	
	for plinth in plinths:
		if !plinth.has_item():
			return false
	
	return true

func plinths_consume_items():
	if !current_recipe:
		return false
	
	if !plinths_has_items():
		return false
	
	for plinth in plinths:
		plinth.consume_item()
	
	return true
