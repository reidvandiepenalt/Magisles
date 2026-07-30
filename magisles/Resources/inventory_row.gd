extends HBoxContainer

@onready var icon: TextureRect = $Icon
@onready var name_label: Label = $ItemName
@onready var amount_label: Label = $Amount
@onready var emoji_label: Label = $Emoji

func setup(item: ItemData, amount: int):
	if item.icon:
		icon.texture = item.icon
		icon.visible = true
		emoji_label.visible = false
	else:
		emoji_label.text = item.emoji
		emoji_label.visible = true
		icon.visible = false
	
	name_label.text = item.item_name
	amount_label.text = str(amount)
