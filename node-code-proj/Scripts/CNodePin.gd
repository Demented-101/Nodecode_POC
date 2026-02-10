extends Node2D
class_name CNodePin

@export var sprite:Sprite2D
@export var drag_zone:Control

signal hover_started(pin:CNodePin)
signal hover_ended(pin:CNodePin)

var type:CNode.pinTypes
var is_output:bool

var _is_connected:bool
var data_bus:DataBus = null
var connected_pin:CNodePin
var cnode:CNode
var index:int

var gradients:Dictionary[CNode.pinTypes, Texture] = {
	CNode.pinTypes.Exc : preload("uid://cshc3blqmgwu3"),
	CNode.pinTypes.Bool : preload("uid://evradaricva"),
	CNode.pinTypes.Int : preload("uid://dtq01u6dywh6x"),
	CNode.pinTypes._String : preload("uid://b7lofff33r0d3")
}

func _ready() -> void:
	drag_zone.mouse_entered.connect(func(): hover_started.emit(self))
	drag_zone.mouse_exited.connect(func(): hover_ended.emit(self))
	
	var drag_handler:BusDragHandler = BusDragHandler.instance
	
	hover_started.connect(drag_handler.pin_hovered)
	hover_ended.connect(drag_handler.pin_hover_ended)

func setup(_type:CNode.pinTypes, _cnode:CNode):
	type = _type
	sprite.texture = gradients[type]
	
	cnode = _cnode

func connected(bus:DataBus) -> void:
	data_bus = bus
	if data_bus.output_pin == self: connected_pin = data_bus.input_pin
	else: connected_pin = data_bus.output_pin
	
	_is_connected = true
	data_bus.Disconnected.connect(disconnected)

func disconnected() -> void:
	_is_connected = false
	data_bus.Disconnected.disconnect(disconnected)
	
	data_bus = null
	connected_pin = null

func get_value() -> Variant:
	if is_output: return cnode.program.get_output(index)
	
	## exc should never return a real value
	if type == CNode.pinTypes.Exc: return null
	
	if _is_connected: return connected_pin.get_value()
	
	## define default values
	match type:
		CNode.pinTypes.Bool: return false
		CNode.pinTypes.Int: return 0
		CNode.pinTypes._String: return ""
		
	return null
