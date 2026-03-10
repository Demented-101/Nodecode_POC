extends CNodeProgram

var loop_count:int = 0

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Run" : CNode.pinTypes.Exc,
	}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Out" : CNode.pinTypes.Exc,
		"Loops" : CNode.pinTypes.Int,
	}

func reset() -> void:
	loop_count = 0

func get_output(index:int, depth:int) -> Variant:
	if index == 1: return loop_count
	return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)

func execute(function:String) -> void:
	var err = verify_inputs(1, 0)
	if err is CNError: 
		ExecutionHandler.instance.add_error_log(err)
		return
	print(function, " - ", str(loop_count))
	if function == "Run":
		loop_count = 0
		loop()
	elif function == "_Returned":
		loop_count += 1
		loop()

func loop() -> void:
	ExecutionHandler.instance.queue_as_return(self)
	output_pins[0].execute()
