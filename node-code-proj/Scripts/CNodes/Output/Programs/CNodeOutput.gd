extends CNodeProgram
class_name OutputProgram

var output_label:Label

func define_outputs() -> Dictionary[String, CNode.pinTypes]: return {}
func define_inputs() -> Dictionary[String, CNode.pinTypes]: return {"value" : CNode.pinTypes.DataAny}
func get_output(_index:int, _depth:int) -> Variant: return null

func _process(_delta:float) -> void: 
	var output = input_pins[0].get_value(0)
	
	if output is CNError:
		if output.type == Const.ErrorType.NoAnyTypeValue:
			output_label.text = "Not Connected"
			output_label.modulate = Color.DIM_GRAY
		else:
			output_label.text = "Error: " + output.type_str
			output_label.modulate = Color.RED
		
	else:
		output_label.text = Const.data_to_string(output, input_pins[0].connected_pin.type)
		output_label.modulate = Color.WHITE
