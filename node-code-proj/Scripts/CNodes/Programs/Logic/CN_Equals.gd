extends CNodeProgram


func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"A" : CNode.pinTypes.DataAny,
		"B" : CNode.pinTypes.DataAny,
	}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Out" : CNode.pinTypes.Bool
	}

func get_output(index:int, depth:int) -> Variant:
	var err = verify_inputs(2, depth)
	if err: return err
	
	if index != 0: return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)
	
	var type_A = input_pins[0].connected_pin.type
	var type_B = input_pins[1].connected_pin.type
	
	if type_A != type_B: return CNError.new(Const.ErrorType.ConnectionError, self, depth)
	return input_values[0] == input_values[1]
	
