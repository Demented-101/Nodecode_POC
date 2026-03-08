extends CNodeProgram

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Run" : CNode.pinTypes.Exc,
		"Value" : CNode.pinTypes.Int,
	}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Out" : CNode.pinTypes.Exc
	}

func get_output(_index:int, depth:int) -> Variant:
	return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)

func execute(_function:String) -> void:
	if _function != "Run": 
		printerr("Invalid function run")
		return
	
	var err = verify_inputs(2, 0)
	if err is CNError: 
		ExecutionHandler.instance.add_log(err.get_simple_error_string())
		return
	
	ExecutionHandler.instance.add_log(str( input_values[1] ))
	output_pins[0].execute()
