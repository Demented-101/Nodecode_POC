extends Node2D
class_name CNode

enum pinTypes {Exc, Bool, Int, _String}

const C_NODE := preload("uid://dy4tla84v3wg6")
const DATA_PIN_IN = preload("uid://dju7ohku7vqkp")
const DATA_PIN_OUT = preload("uid://c5eg8t1gmea44")
var program:CNodeProgram

@export var drag_zone:Container
@export var header:Polygon2D
@export var body:Polygon2D
@export var title_label:Label

var mouse_hovering:bool = false
var is_dragging:bool = false
var drag_offset:Vector2
static var drag_in_use:bool = false

func _ready() -> void:
	drag_zone.mouse_entered.connect(func(): mouse_hovering = true)
	drag_zone.mouse_exited.connect(func(): mouse_hovering = false)

func set_program(_program:CNodeProgram) -> void:
	program = _program
	add_child(program)
	
	populate_pins()
	update_display()

func _input(event: InputEvent) -> void:
	if event.is_action(&"L_click"):
		if event.is_pressed() and mouse_hovering: start_drag()
		else: end_drag()

func start_drag():
	if drag_in_use: return
	
	is_dragging = true 
	get_parent().move_child(self, -1)
	
	var mouse_pos:Vector2 = get_global_mouse_position()
	drag_offset = global_position - mouse_pos

func end_drag():
	if is_dragging:
		is_dragging = false
		drag_in_use = false

func _process(_delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() + drag_offset

func populate_pins() -> void:
	## setup outputs
	var outputs:Dictionary[String, pinTypes] = program.define_outputs()
	program.output_count = outputs.size()
	
	for i:int in program.output_count:
		var new_out_pin:DataPinOut = DATA_PIN_OUT.instantiate()
		add_child(new_out_pin)
		program.output_pins.append(new_out_pin)
		
		new_out_pin.position = Vector2(program.definition.width, 65 + (i * 30))
		new_out_pin.setup(outputs.values()[i], self, i)
	
	## setup inputs
	var inputs:Dictionary[String, pinTypes] = program.define_inputs()
	program.input_count = inputs.size()
	
	for i:int in program.input_count:
		var new_in_pin:DataPinIn = DATA_PIN_IN.instantiate()
		add_child(new_in_pin)
		program.input_pins.append(new_in_pin)
		
		new_in_pin.position = Vector2(0, 65 + (i * 30))
		new_in_pin.setup(inputs.values()[i], self, i)

func update_display() -> void:
	var width:int = program.definition.width
	var height:int = 20 + (max(program.input_count, program.output_count) * 30)
	
	header.polygon = [
		Vector2(width, 0), Vector2(width, 40), Vector2(0, 40), Vector2(0, 0)
	]
	header.uv = [
		Vector2(0, 40), Vector2(0, 0), Vector2(width, 0), Vector2(width, 40)
	]
	
	body.polygon = [
		Vector2(width, 0), Vector2(width, height), Vector2(0, height), Vector2(0, 0)
	]
	body.uv = [
		Vector2(0, height), Vector2(0, 0), Vector2(width, 0), Vector2(width, height)
	]
	
	drag_zone.size.x = width
	title_label.text = program.definition.display_name
