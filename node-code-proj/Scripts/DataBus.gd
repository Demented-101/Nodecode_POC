extends Node2D
class_name DataBus

var output_pin:CNodePin
var input_pin:CNodePin

signal Disconnected(_self:DataBus)

func create(_out:CNodePin, _in:CNodePin) -> void:
	output_pin = _out
	input_pin = _in
	
	input_pin.connected(self)

func remove() -> void:
	Disconnected.emit(self)
	queue_free()
