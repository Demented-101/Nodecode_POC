extends Node
class_name CNodeEnvironment

static var instance:CNodeEnvironment

func _ready() -> void:
	if instance != null: queue_free()
	instance = self
