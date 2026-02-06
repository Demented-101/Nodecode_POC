extends Node2D
class_name CNode

enum pinTypes {_Bool, _Int, _Float, _String, Variant_Num}

@export var drag_zone:Container
@export var header:Polygon2D
@export var body:Polygon2D

@export_category("Settings")
@export var node_name:String = "Node Name"
@export var node_width:float = 400

var mouse_hovering:bool = false
var is_dragging:bool = false
var drag_offset:Vector2
static var drag_in_use:bool = false

var data_output_count:int
var data_input_count:int
var input_pins:Array[DataPinOut]
var output_pins:Array[DataPinIn]

func _ready() -> void:
	drag_zone.mouse_entered.connect(func(): mouse_hovering = true)
	drag_zone.mouse_exited.connect(func(): mouse_hovering = false)
	
	data_input_count = define_inputs().size()
	data_output_count = define_outputs().size()

func _input(event: InputEvent) -> void:
	if event.is_action(&"L_click"):
		if event.is_pressed() and mouse_hovering: start_drag()
		else: end_drag()

func start_drag():
	if drag_in_use: return
	
	is_dragging = true 
	get_parent().move_child(self, -1)
	
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	drag_offset = position - mouse_pos

func end_drag():
	if is_dragging:
		is_dragging = false
		drag_in_use = false

func _process(_delta: float) -> void:
	if is_dragging:
		position = get_viewport().get_mouse_position() + drag_offset

func define_outputs() -> Dictionary[String, pinTypes]:
	return {}

func get_output(_index:int) -> Variant:
	return null

func define_inputs() -> Dictionary[String, pinTypes]:
	return {}

func populate_pins() -> void:
	var outputs:Dictionary[String, pinTypes] = define_outputs()
	var inputs:Dictionary[String, pinTypes] = define_inputs()
