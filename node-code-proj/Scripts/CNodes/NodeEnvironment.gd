extends Node
class_name CNodeEnvironment

static var instance:CNodeEnvironment

func _ready() -> void:
	if instance != null: 
		free()
		return
	instance = self
