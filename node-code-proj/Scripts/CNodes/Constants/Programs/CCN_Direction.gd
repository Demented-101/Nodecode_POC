extends ConstantProgram

const DIRECTION_CONST_INTERFACE = preload("uid://btcqtisjqkwdp")

func _ready() -> void:
	value = Robot.directions.Forward

func define_outputs() -> Dictionary[String, CNode.pinTypes]:
	return {"Output" : CNode.pinTypes.Direction}

func set_value(new_value:Variant) -> void:
	value = new_value

func define_interface() -> PackedScene:
	return DIRECTION_CONST_INTERFACE
