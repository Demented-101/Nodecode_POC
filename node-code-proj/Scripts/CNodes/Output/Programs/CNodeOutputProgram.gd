@abstract
extends CNodeProgram
class_name OutputProgram

var output_label:Label

func define_outputs() -> Dictionary[String, CNode.pinTypes]: return {}
func get_output(_index:int, _depth:int) -> Variant: return null

func _process(_delta:float) -> void: 
	var output = input_pins[0].get_value(0)
	
	if output is CNError:
		output_label.text = "Error: " + output.type_str
	else:
		output_label.text = str(output)
