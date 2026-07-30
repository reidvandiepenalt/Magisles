extends Resource
class_name SkillData

@export var display_name: String
@export var description: String
@export var icon: Texture2D

@export var hex_coord: Vector2i

@export var cost: int = 1

@export var prerequisites: Array[SkillData]
