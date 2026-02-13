@abstract
extends CNodeProgram
class_name ConstantProgram

var value:Variant

func define_inputs() -> Dictionary[String, CNode.pinTypes]: return {}
func get_output(index:int) -> Variant: return value if index == 0 else null

@abstract func set_value(new_value:Variant) -> void
@abstract func define_interface() -> PackedScene
