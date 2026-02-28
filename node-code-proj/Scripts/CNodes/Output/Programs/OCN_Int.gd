extends OutputProgram

func _ready() -> void:
	definition = load("uid://3giehi2so4s8")
	
func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {"output" : CNode.pinTypes.Int}
