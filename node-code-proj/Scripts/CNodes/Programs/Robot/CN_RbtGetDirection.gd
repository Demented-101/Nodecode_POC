extends CNodeProgram

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return { }

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Direction" : CNode.pinTypes.Direction,
	}

func get_output(_index:int, depth:int) -> Variant:
	if _index != 0: return CNError.new(Const.ErrorType.NoExpectedValue, self, depth)
	return Robot.instance.get_direction()
