@abstract
extends CNodeProgram
class_name ConstantProgram

var value:Variant

func define_inputs() -> Dictionary[String, CNode.pinTypes]: return {}
func get_output(index:int, depth:int) -> Variant: 
	if index != 0: return CNError.new(Const.ErrorType.PinValidityError, self, depth)
	return value

@abstract func set_value(new_value:Variant) -> void
@abstract func define_interface() -> PackedScene
