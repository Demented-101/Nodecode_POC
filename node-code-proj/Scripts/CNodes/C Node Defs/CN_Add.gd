extends CNodeProgram

func _ready() -> void:
	display_name = "Add"
	node_width = 120

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"A" : CNode.pinTypes.Int,
		"B" : CNode.pinTypes.Int,
	}
	
func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Out" : CNode.pinTypes.Int
	}

func get_output(index:int) -> Variant:
	match index:
		0: return input_pins[0].get_value() + input_pins[1].get_value()
	
	return null
