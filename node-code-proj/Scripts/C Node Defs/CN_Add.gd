extends CNode

func define_inputs() -> Dictionary[String, pinTypes]:
	return {
		"A" : pinTypes.Variant_Num,
		"B" : pinTypes.Variant_Num,
	}
	
func define_outputs() -> Dictionary[String, pinTypes]:
	return {
		"Out" : pinTypes._Float
	}

func get_output(index:int) -> Variant:
	match index:
		0:
			return input_pins[0].get_value() + input_pins[1].get_value()
	
	return null
