extends ConstantProgram

func _ready() -> void:
	value = CNError.new(Const.ErrorType.NoExpectedValue, self, -1)
	ExecutionHandler.instance.execution_started.connect(func():
		output_pins[0].execute()
	)

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {"Output" : CNode.pinTypes.Exc}

func set_value(_new_value:Variant) -> void: pass
func define_interface() -> PackedScene: return null
