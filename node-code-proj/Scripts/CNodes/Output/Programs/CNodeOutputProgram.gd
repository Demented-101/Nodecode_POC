@abstract
extends CNodeProgram
class_name OutputProgram

var output_label:Label

func define_outputs() -> Dictionary[String, CNode.pinTypes]: return {}
func get_output(_index:int) -> Variant: return null
func _process(_delta:float) -> void: output_label.text = str(input_pins[0].get_value())
