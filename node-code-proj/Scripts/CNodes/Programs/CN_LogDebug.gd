extends CNodeProgram

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Run" : CNode.pinTypes.Exc
	}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Out" : CNode.pinTypes.Exc
	}

func get_output(index:int, depth:int) -> Variant:
	var err = verify_inputs(2, depth)
	if err: return err
	
	match index:
		0: return input_values[0] + input_values[1]
	
	return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)

func execute(_function:String) -> void:
	if _function != "Run": return
	
	print("RUNNING",self)
	output_pins[0].execute()
