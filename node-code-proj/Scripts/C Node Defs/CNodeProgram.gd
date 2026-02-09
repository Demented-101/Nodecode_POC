extends Node
class_name CNodeProgram

var output_count:int
var input_count:int
var input_pins:Array[CNodePin]
var output_pins:Array[CNodePin]

var display_name:String
var node_width:int

func define_inputs() -> Dictionary[String, CNode.pinTypes]:
	return {}

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {}

func get_output(_index:int) -> Variant:
	return null
