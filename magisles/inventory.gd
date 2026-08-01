extends Node
class_name Inventory

var items: Dictionary = {}

signal item_added(item: ItemData, amount: int)
signal item_removed(item: ItemData, amount: int)
signal inventory_changed

func add_item(item: ItemData, amount := 1):
	items[item] = items.get(item, 0) + amount
	
	item_added.emit(item, amount)
	inventory_changed.emit()

func remove_item(item: ItemData, amount := 1) -> bool:
	if get_amount(item) < amount:
		return false

	items[item] -= amount

	if items[item] <= 0:
		items.erase(item)

	item_removed.emit(item, amount)
	inventory_changed.emit()
	return true

func get_amount(item: ItemData) -> int:
	return items.get(item, 0)

func has_items(recipe: RecipeData):
	for ingredient in recipe.ingredients:
		if get_amount(ingredient.item) < ingredient.amount:
			return false
	
	return true

func consume(recipe: RecipeData):
	if !has_items(recipe):
		return false
		
	for ingredient in recipe.ingredients:
		if ingredient.amount <= 0:
			continue
		
		items[ingredient.item] -= ingredient.amount
		item_removed.emit(ingredient.item, ingredient.amount)
		
		if items[ingredient.item] <= 0:
			items.erase(ingredient.item)
	
	inventory_changed.emit()
	return true

func has_items_ingredient(ingredient: Ingredient):
	if get_amount(ingredient.item) < ingredient.amount:
		return false
	
	return true

func consume_ingredient(ingredient: Ingredient):
	if !has_items_ingredient(ingredient):
		return false
		
	if ingredient.amount <= 0:
		return true
		
	items[ingredient.item] -= ingredient.amount
	item_removed.emit(ingredient.item, ingredient.amount)
		
	if items[ingredient.item] <= 0:
		items.erase(ingredient.item)
	
	inventory_changed.emit()
	return true


func get_missing_items(recipe: RecipeData) -> Array[Ingredient]:
	var missing: Array[Ingredient] = []
	
	for ingredient in recipe.ingredients:
		if get_amount(ingredient.item) < ingredient.amount:
			missing.append(ingredient)
	
	return missing
