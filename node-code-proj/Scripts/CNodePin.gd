extends Node2D
class_name CNodePin

@export var sprite:Sprite2D
@export var drag_zone:Control

signal clicked
signal dragging
signal drag_released

var type:CNode.pinTypes
var is_output:bool

var _is_connected:bool
var data_bus:DataBus = null
var connected_pin:CNodePin
var cnode:CNode
var index:int

var mouse_hovering:bool = false
var click_timer:float = 0
const hold_duration:float = 0.5
var is_dragging:bool = false
static var drag_in_use:bool = false

var gradients:Dictionary[CNode.pinTypes, Texture] = {
	CNode.pinTypes.Exc : preload("uid://cshc3blqmgwu3"),
	CNode.pinTypes.Bool : preload("uid://evradaricva"),
	CNode.pinTypes.Int : preload("uid://dtq01u6dywh6x"),
	CNode.pinTypes._String : preload("uid://b7lofff33r0d3")
}

func _ready() -> void:
	drag_zone.mouse_entered.connect(func(): mouse_hovering = true)
	drag_zone.mouse_exited.connect(func(): mouse_hovering = false)

func _input(event: InputEvent) -> void:
	if event.is_action(&"L_click"):
		if event.is_pressed() and mouse_hovering: start_drag()
		else: end_drag()

func start_drag():
	if drag_in_use: return
	is_dragging = true
	drag_in_use = true

func end_drag():
	if is_dragging:
		is_dragging = false
		drag_in_use = false
		
		if click_timer <= hold_duration: clicked.emit()
		else: drag_released.emit()

func _process(delta: float) -> void:
	if is_dragging: 
		click_timer += delta
		if click_timer > hold_duration: dragging.emit()

func setup(_type:CNode.pinTypes):
	type = _type
	sprite.texture = gradients[type]

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
