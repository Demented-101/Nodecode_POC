@abstract class_name CNodeBus
extends Line2D

signal Disconnected(_self:CNodeBus)

var gradients:Dictionary[CNode.pinTypes, Texture] = {
	CNode.pinTypes.Exc : preload("uid://cshc3blqmgwu3"),
	CNode.pinTypes.Bool : preload("uid://evradaricva"),
	CNode.pinTypes.Int : preload("uid://dtq01u6dywh6x"),
	CNode.pinTypes._String : preload("uid://b7lofff33r0d3")
}
var input_pin:CNodePin
var output_pin:CNodePin

@abstract func create(_out:CNodePin, _in:CNodePin) -> void

func remove() -> void:
	Disconnected.emit(self)
	queue_free()

func _process(_delta: float) -> void:
	global_position = Vector2(0,0)
	points = [output_pin.global_position, input_pin.global_position]

static func check_pin_validity(_pinA:CNodePin, _pinB:CNodePin) -> bool:
	return false
