extends CNodeProgram


func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"In" : CNode.pinTypes.Bool,
	}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Out" : CNode.pinTypes.Bool
	}

func get_output(index:int, depth:int) -> Variant:
	var err = verify_inputs(1, depth)
	if err: return err
	
	match index:
		0: return !input_values[0]
	
	return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)
