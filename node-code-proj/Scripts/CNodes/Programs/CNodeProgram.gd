@abstract
extends Node
class_name CNodeProgram

var output_count:int
var input_count:int
var input_pins:Array[CNodePin]
var input_values:Array
var output_pins:Array[CNodePin]
var definition:CNodeDefinition

@abstract func define_inputs() -> Dictionary[String, CNode.pinTypes]
@abstract func define_outputs() -> Dictionary[String, CNode.pinTypes]
@abstract func get_output(_index:int, _depth:int) -> Variant

func verify_inputs(amount:int, depth:int) -> CNError:
	input_values = []
	
	for i in range(amount):
		var pin := input_pins[i]
		if pin == null: return CNError.new(Const.ErrorType.PinValidityError, self)
		
		input_values.append(pin.get_value(depth))
		if input_values[i] is CNError: return input_values[i]
	
	return null
