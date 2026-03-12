@abstract
extends Node
class_name CNodeProgram

var output_count:int
var input_count:int
var input_pins:Array[CNodePin]
var input_values:Array
var output_pins:Array[CNodePin]
var definition:CNodeDefinition
var cnode:CNode

@abstract func define_inputs() -> Dictionary[String, CNode.pinTypes]
@abstract func define_outputs() -> Dictionary[String, CNode.pinTypes]
@abstract func get_output(_index:int, _depth:int) -> Variant

func _ready() -> void:
	ExecutionHandler.instance.execution_ended.connect(reset)

func verify_inputs(amount:int, depth:int) -> CNError:
	input_values = []
	
	for i in range(amount):
		var pin := input_pins[i]
		if pin == null: return CNError.new(Const.ErrorType.PinValidityError, self)
		
		if pin.type == CNode.pinTypes.Exc:
			input_values.append(CNError.new(Const.ErrorType.NoExpectedValue, self, depth))
		else:
			input_values.append(pin.get_value(depth))
			if input_values[i] is CNError: return input_values[i]
	
	return null

func define_actions() -> Array[String]:
	return [
		"Clone", "Delete", "Disconnect All",
	]

func reset() -> void: return

func execute(_function:String) -> void: return
func run_action(_action:String) -> void:
	match(_action):
		"Clone":
			CNodeEnvironment.instance.add_new_CNode(definition)
		"Delete":
			if input_pins.size() > 0: for i in input_pins: i.disconnect_all()
			if output_pins.size() > 0: for i in output_pins: i.disconnect_all()
			cnode.queue_free()
		"Disconnect All":
			if input_pins.size() > 0: for i in input_pins: i.disconnect_all()
			if output_pins.size() > 0: for i in output_pins: i.disconnect_all()
