extends Control

@onready var node_layer = $Nodes
@onready var skill_points_label: Label = $MarginContainer/HBoxContainer/SkillPointsNumber 

@export var skill_scene: PackedScene
@export var skills: Array[SkillData]

@export var HEX_SIZE := 40.0

var skill_points = 0

func hex_to_pixel(hex: Vector2i) -> Vector2:
	return Vector2(
		HEX_SIZE * (hex.x + hex.y * 0.5),
		HEX_SIZE * hex.y
	)

func _ready():
	create_nodes()

func create_nodes():
	for skill in skills:
		var node = skill_scene.instantiate()
		node.setup(skill)
		var center = node_layer.size / 2
		node.position = center + hex_to_pixel(skill.hex_coord) - Vector2(HEX_SIZE, HEX_SIZE) / 2
		node_layer.add_child(node)

func update_skill_points(amount: int):
	skill_points += amount
	skill_points_label.text = str(skill_points)
