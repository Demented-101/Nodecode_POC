@abstract class_name CNodePin
extends Node2D

@export var sprite:Sprite2D
@export var drag_zone:Control
@export var name_label:Label

@warning_ignore("shadowed_variable_base_class")
var is_connected:bool ## if the pin has at least one connection
var type:CNode.pinTypes ## the data-type of the pin
var cnode:CNode ## the CNode it is connected to
var index:int ## the index of the pin (top to bottom)
var pin_name:String ## the given name of the pin

var gradients:Dictionary[CNode.pinTypes, Texture] = { ## stores all the pin gradients
	CNode.pinTypes.Exc : preload("uid://cshc3blqmgwu3"),
	CNode.pinTypes.Bool : preload("uid://evradaricva"),
	CNode.pinTypes.Int : preload("uid://dtq01u6dywh6x"),
	CNode.pinTypes._String : preload("uid://b7lofff33r0d3"),
	CNode.pinTypes.Direction : preload("uid://15rgqj104wv2"),
}

func _ready() -> void:
	## connect the mouse hover events to the drag handler
	var drag_handler:BusDragHandler = BusDragHandler.instance
	drag_zone.mouse_entered.connect(drag_handler.pin_hovered.bind(self))
	drag_zone.mouse_exited.connect(drag_handler.pin_hover_ended.bind(self))
	z_index = 1

func setup(_type:CNode.pinTypes, _cnode:CNode, _index:int, _name:String, hide_pin_names:bool):
	## update the type and cnode of the pin
	type = _type
	sprite.texture = gradients[type]
	cnode = _cnode
	index = _index
	
	pin_name = _name
	name_label.text = _name
	if hide_pin_names: name_label.hide()

## used for being connected + disconnected from a databus
@abstract func connected(_new_bus:CNodeBus) -> void
@abstract func disconnected(_bus:CNodeBus) -> void
@abstract func disconnect_all() -> void

## passes on the value
@abstract func get_value(_depth:int) -> Variant
func execute() -> void: return

## used when the mouse clicks on the pin
@abstract func on_clicked() -> void
