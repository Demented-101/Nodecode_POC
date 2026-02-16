@abstract
extends Node
class_name CNodeProgram

var output_count:int
var input_count:int
var input_pins:Array[DataPinIn]
var output_pins:Array[DataPinOut]

var display_name:String
var node_width:int

@abstract func define_inputs() -> Dictionary[String, CNode.pinTypes]
@abstract func define_outputs() -> Dictionary[String, CNode.pinTypes]
@abstract func get_output(_index:int) -> Variant

func verify_inputs(amount:int) -> bool:
	for i in range(amount):
		var pin := input_pins[i]
		if pin == null or pin.get_value() == null: return false
	
	return true
