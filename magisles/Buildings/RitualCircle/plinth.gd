extends StaticBody2D
class_name Plinth

var held_item: Ingredient
var recipe_item: Ingredient

@onready var ritual_circle: RitualCircle = get_parent()

func interact(player: PlayerScript) -> void:
	if !recipe_item:
		return
	
	if !held_item:
		if player.inventory.consume_ingredient(recipe_item):
			held_item = recipe_item
	else:
		clear_item(player)

func clear_item(player: PlayerScript):
	if held_item:
		player.inventory.add_item(held_item.item, held_item.amount)

func consume_item():
	held_item = null

func has_item():
	if !recipe_item:
		return true
	
	if !held_item:
		return false
	
	if(recipe_item.item != held_item.item):
		print("What da helly: recipe item does not equal held item")
		print("recipe item: ", recipe_item.item)
		print("held item: ", held_item.item)
	
	if held_item.amount >= recipe_item.amount:
		return true
	else:
		return false
