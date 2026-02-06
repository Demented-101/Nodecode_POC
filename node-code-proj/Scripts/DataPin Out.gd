extends Sprite2D
class_name DataPinOut

var type:CNode.pinTypes
var cnode:CNode
var index:int

@onready var texture_file = preload("uid://evradaricva")

func _ready() -> void:
	texture = texture_file.duplicate()

func get_value() -> Variant:
	return cnode.get_output(index)
