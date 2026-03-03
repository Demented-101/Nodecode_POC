extends CNodeProgram


func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"A" : CNode.pinTypes.Bool,
		"B" : CNode.pinTypes.Bool,
	}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Out" : CNode.pinTypes.Bool
	}

func get_output(index:int, depth:int) -> Variant:
	var err = verify_inputs(2, depth)
	if err: return err
	
	match index:
		0: return input_values[0] != input_values[1]
	
	return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)
