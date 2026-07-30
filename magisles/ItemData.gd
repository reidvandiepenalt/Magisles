extends Resource
class_name ItemData

@export var item_name: String
@export var icon: Texture2D
@export var max_stack := 999
@export var emoji := ""

func get_id() -> String:
	return resource_path.get_file().get_basename()
