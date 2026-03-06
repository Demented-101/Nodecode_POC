extends ConstantProgram

const EXC_DEBUG_CONST_INTERFACE = preload("uid://bwaootj3fukhh")

func _ready() -> void:
	value = CNError.new(Const.ErrorType.NoExpectedValue, self, -1)

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {"Output" : CNode.pinTypes.Exc}

func set_value(_new_value:Variant) -> void: 
	output_pins[0].execute()

func define_interface() -> PackedScene:
	return EXC_DEBUG_CONST_INTERFACE
