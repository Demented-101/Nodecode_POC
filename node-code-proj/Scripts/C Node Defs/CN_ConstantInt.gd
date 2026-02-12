extends CNodeProgram

func define_inputs() -> Dictionary[String, CNode.pinTypes]: return {}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {
		"Output" : CNode.pinTypes.Int
	}

func get_output(_index:int) -> Variant:
	if _index != 0: return null
	
	return 0
