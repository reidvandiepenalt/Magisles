extends HBoxContainer
class_name PickupPopup

@onready var icon: TextureRect = $Icon
@onready var label: Label = $Label
@onready var emoji: Label = $Emoji

var item: ItemData
var amount: int = 0

var tween: Tween

func setup(new_item: ItemData, new_amount: int):
	item = new_item
	
	if item.icon:
		icon.texture = item.icon
		icon.visible = true
		emoji.visible = false
	else:
		emoji.text = item.emoji
		emoji.visible = true
		icon.visible = false

	add_amount(new_amount)

func add_amount(extra: int):
	amount += extra
	label.text = "%s x%d" % [item.item_name, amount]

	# Restart the animation every time more of this item is collected.
	if tween:
		tween.kill()
	
	modulate.a = 1.0
	
	tween = create_tween()
	
	# Fade in
	tween.parallel().tween_property(self, "modulate:a", 1.0, 0.15)
	
	# Stay visible for 1.5 second
	tween.tween_interval(1.5)
	
	# Fade out
	tween.tween_property(self, "modulate:a", 0.0, 0.25)
	
	tween.finished.connect(queue_free)
