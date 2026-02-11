extends CNodeProgram

func _ready() -> void:
	display_name = "String Add"
	node_width = 240

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"A" : CNode.pinTypes._String,
		"B" : CNode.pinTypes._String,
	}
	
func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Out" : CNode.pinTypes._String
	}

func get_output(index:int) -> Variant:
	match index:
		0: return input_pins[0].get_value() + input_pins[1].get_value()
	
	return null
