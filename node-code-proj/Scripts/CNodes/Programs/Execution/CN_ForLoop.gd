extends CNodeProgram

var loop_count:int = 0
var loops_remaining:int = 0

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Run" : CNode.pinTypes.Exc,
		"For" : CNode.pinTypes.Int,
	}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"looped" : CNode.pinTypes.Exc,
		"Finished" : CNode.pinTypes.Exc,
		"Loops" : CNode.pinTypes.Int,
	}

func reset() -> void:
	loop_count = 0
	loops_remaining = 0

func get_output(index:int, depth:int) -> Variant:
	if index == 2: return loop_count
	return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)

func execute(function:String) -> void:
	var err = verify_inputs(2, 0)
	if err is CNError: 
		ExecutionHandler.instance.add_error_log(err)
		return
	
	if function == "Run":
		loop_count = 0
		loops_remaining = input_values[1]
		loop()
	
	elif function == "_Returned":
		loop_count += 1
		loop()

func loop() -> void:
	if loops_remaining == 0: 
		output_pins[1].execute()
		return
	
	loops_remaining -= 1
	ExecutionHandler.instance.queue_as_return(self)
	output_pins[0].execute()
