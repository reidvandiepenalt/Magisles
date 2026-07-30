extends Control

var skill: SkillData

func setup(skill_data: SkillData):
	skill = skill_data
	$Icon.texture = skill.icon
