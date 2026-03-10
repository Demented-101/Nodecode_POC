extends ConstantProgram

func _ready() -> void:
	value = CNError.new(Const.ErrorType.NoExpectedValue, self, -1)
	ExecutionHandler.instance.execution_started.connect(func():
		ExecutionHandler.instance.queue_as_return(self)
		output_pins[0].execute()
	)

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {"Output" : CNode.pinTypes.Exc}

func execute(function:String) -> void:
	if function == "_Returned":
		ExecutionHandler.instance.end_execution()

func set_value(_new_value:Variant) -> void: pass
func define_interface() -> PackedScene: return null
