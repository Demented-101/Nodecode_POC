extends ConstantProgram

const INT_CONST_INTERFACE = preload("uid://bnlie5irs623t")

func _ready() -> void:
	definition = load("uid://r3ufqbs7nkug")
	value = 0

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {"Output" : CNode.pinTypes.Int}

func set_value(new_value:Variant) -> void:
	value = new_value

func define_interface() -> PackedScene:
	return INT_CONST_INTERFACE
