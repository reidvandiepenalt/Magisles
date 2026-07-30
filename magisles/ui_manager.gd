extends CanvasLayer
class_name UIManager

@export var player: PlayerScript

var current_menu: Control = null

@export var inventory: Control
@export var build_menu: Control
@export var skill_tree: Control

func open_menu(menu: Control):
	# Already open?
	if current_menu == menu:
		return

	# Close previous
	if current_menu:
		current_menu.visible = false

	current_menu = menu
	current_menu.visible = true

	player.input_state.block(&"menu")
	
	if menu.has_method("open"):
		menu.open()


func close_menu(menu: Control):
	if current_menu != menu:
		return

	current_menu.visible = false
	current_menu = null

	player.input_state.unblock(&"menu")


func toggle_menu(menu: Control):
	if current_menu == menu:
		close_menu(menu)
	else:
		open_menu(menu)


func is_menu_open() -> bool:
	return current_menu != null

func _input(event) -> void:
	if event.is_action_pressed("Inventory"):
		toggle_menu(inventory)
	elif event.is_action_pressed("Build"):
		toggle_menu(build_menu)
	elif event.is_action_pressed("skill_tree"):
		toggle_menu(skill_tree)
	elif (event.is_action_pressed("ui_cancel")):
		close_menu(current_menu)
