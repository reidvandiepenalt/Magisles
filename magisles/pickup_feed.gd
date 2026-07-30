extends Control

@export var popup_scene: PackedScene
@onready var inventory: Inventory = $"../../Inventory"
@onready var list = $MarginContainer/VBoxContainer

var active_popups: Dictionary = {}

func _ready():
	inventory.item_added.connect(show_popup)

func show_popup(item: ItemData, amount: int):
	# Already showing this item? Just update it.
	if active_popups.has(item):
		active_popups[item].add_amount(amount)
		return
	
	# Otherwise create a new popup.
	var popup: PickupPopup = popup_scene.instantiate()
	
	list.add_child(popup)
	
	popup.setup(item, amount)
	
	active_popups[item] = popup
	
	popup.tree_exited.connect(_on_popup_removed.bind(item))

func _on_popup_removed(item: ItemData):
	active_popups.erase(item)
