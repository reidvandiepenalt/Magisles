extends Node
class_name InputState

var blockers: Dictionary = {}

func block(reason: StringName):
	blockers[reason] = true

func unblock(reason: StringName):
	blockers.erase(reason)

func gameplay_enabled() -> bool:
	return blockers.is_empty()
