extends OutputProgram

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {"output" : CNode.pinTypes.Bool}
