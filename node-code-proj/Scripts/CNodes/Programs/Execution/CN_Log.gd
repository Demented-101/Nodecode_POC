extends CNodeProgram

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Run" : CNode.pinTypes.Exc,
		"Value" : CNode.pinTypes.DataAny,
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
		LogsHandler.instance.add_error_log(err)
		return
	
	LogsHandler.instance.add_log(Const.data_to_string(input_values[1], input_pins[1].connected_pin.type))
	output_pins[0].execute()
