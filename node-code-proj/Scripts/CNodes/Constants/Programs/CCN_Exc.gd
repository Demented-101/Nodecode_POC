extends ConstantProgram

static var instance:ConstantProgram

func _ready() -> void:
	if is_instance_valid(instance):
		queue_free()
		cnode.queue_free()
		LogsHandler.instance.add_error_log(CNError.new(Const.ErrorType.BeginningError))
		return
	 
	instance = self
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
