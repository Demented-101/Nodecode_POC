extends ConstantProgram

const BOOL_CONST_INTERFACE = preload("uid://c5gv5tql5jlr0")

func _ready() -> void:
	value = false

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {"Output" : CNode.pinTypes.Bool}

func set_value(new_value:Variant) -> void:
	value = new_value

func define_interface() -> PackedScene:
	return BOOL_CONST_INTERFACE
