extends CNodeProgram

var loop_count:int = 0

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Run" : CNode.pinTypes.Exc,
		"While" : CNode.pinTypes.Bool,
	}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"looped" : CNode.pinTypes.Exc,
		"Finished" : CNode.pinTypes.Exc,
		"Loops" : CNode.pinTypes.Int,
	}

func reset() -> void:
	loop_count = 0

func get_output(index:int, depth:int) -> Variant:
	if index == 1: return loop_count
	return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)

func execute(function:String) -> void:
	var err = verify_inputs(2, 0)
	if err is CNError: 
		ExecutionHandler.instance.add_error_log(err)
		return
	
	var do_continue:bool = input_values[1]
	if function == "Run":
		loop_count = 0
		loop(do_continue)
	elif function == "_Returned":
		loop_count += 1
		loop(do_continue)

func loop(do_loop:bool) -> void:
	if !do_loop: 
		output_pins[1].execute()
		return
	
	ExecutionHandler.instance.queue_as_return(self)
	output_pins[0].execute()
