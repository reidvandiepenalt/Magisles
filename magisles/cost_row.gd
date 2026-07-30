extends HBoxContainer

@onready var icon: TextureRect = $Icon
@onready var label: Label = $Label
@onready var emoji: Label = $Emoji

var ingredient: Ingredient

func setup(_ingredient: Ingredient, inventory: Inventory):
	ingredient = _ingredient
	if ingredient.item.icon:
		icon.texture = ingredient.item.icon
		icon.visible = true
		emoji.visible = false
	else:
		emoji.text = ingredient.item.emoji
		emoji.visible = true
		icon.visible = false
	
	refresh(inventory)

func refresh(inventory: Inventory):
	var owned = inventory.get_amount(ingredient.item)

	label.text = "%d / %d" % [owned, ingredient.amount]

	if owned >= ingredient.amount:
		label.modulate = Color.LIME_GREEN
	else:
		label.modulate = Color.RED
