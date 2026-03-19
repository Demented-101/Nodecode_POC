extends CNodeProgram

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Run" : CNode.pinTypes.Exc,
	}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Run" : CNode.pinTypes.Exc,
	}

func get_output(_index:int, depth:int) -> Variant:
	return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)

func execute(_function:String) -> void:
	if _function != "Run":
		printerr("Invalid function run")
		return
	
	var err = verify_inputs(1, 0)
	if err is CNError: 
		ExecutionHandler.instance.add_error_log(err)
		return
	
	Robot.instance.move_forward()
	output_pins[0].execute()
