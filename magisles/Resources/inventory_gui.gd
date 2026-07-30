extends Control

@export var row_scene: PackedScene

@onready var item_list = $CenterContainer/Panel/MarginContainer/ScrollContainer/VBoxContainer
@onready var inventory: Inventory = $"../../Inventory"

func _ready():
	inventory.inventory_changed.connect(refresh)
	refresh()

func refresh():
	for child in item_list.get_children():
		child.queue_free()
	
	var sorted = inventory.items.keys()
	sorted.sort_custom(func(a, b):
		return a.item_name < b.item_name
	)
	
	for item in sorted:
		var row = row_scene.instantiate()
		item_list.add_child(row)
		row.setup(item, inventory.items[item])
