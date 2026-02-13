extends OutputProgram

func _ready() -> void:
	display_name = "Int Output"
	node_width = 200

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {"output" : CNode.pinTypes.Int}
