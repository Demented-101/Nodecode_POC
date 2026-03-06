extends Node
class_name BusDragHandler

static var instance:BusDragHandler

var click_timer:float = 0
const hold_duration:float = 0.2

var is_dragging:bool
var pin:CNodePin
var line:Line2D
var hovered_pin:CNodePin

func _ready() -> void:
	if instance != null: 
		free()
		return
	instance = self

func _input(event: InputEvent) -> void:
	if event.is_action(&"L_click"):
		if event.is_pressed() and hovered_pin != null: start_drag()
		else: end_drag()

func _process(delta: float) -> void:
	if is_dragging: 
		click_timer += delta
		if click_timer > hold_duration: dragging()

func start_drag() -> void:
	is_dragging = true
	pin = hovered_pin
	line = Line2D.new()
	add_child(line)
	
	line.z_index = 1
	pin.z_index = 2
	line.default_color = Color(0.646, 0.646, 0.646, 0.8)
	line.width = 5
	
	line.position = Vector2(0,0)
	line.hide()

func dragging() -> void:
	var target_position:Vector2
	if hovered_pin:
		target_position = hovered_pin.global_position
	else:
		target_position = pin.get_global_mouse_position()
	
	line.visible = true
	line.points = [target_position, pin.global_position]

func end_drag() -> void:
	if !is_dragging: return
	var was_click := click_timer <= hold_duration
	
	is_dragging = false
	line.queue_free()
	pin.z_index = 0
	click_timer = 0
	
	if !was_click:
		if DataBus.check_pin_validity(pin, hovered_pin):
			if pin is DataPinOut: create_connection(pin, hovered_pin, false)
			else: create_connection(hovered_pin, pin, false)
		elif ExecutionBus.check_pin_validity(pin, hovered_pin):
			if pin is ExecutionPinOut: create_connection(pin, hovered_pin, true)
			else: create_connection(hovered_pin, pin, true)
	else:
		hovered_pin.on_clicked()

func pin_hovered(target_pin:CNodePin) -> void:
	hovered_pin = target_pin

func pin_hover_ended(target_pin:CNodePin) -> void:
	if hovered_pin == target_pin: hovered_pin = null

func create_connection(output_pin:CNodePin, input_pin:CNodePin, is_execution:bool) -> void:
	var new_bus 
	if is_execution:
		print("hello")
		new_bus = ExecutionBus.new()
		if output_pin.execution_bus != null: output_pin.execution_bus.remove()
	else:
		new_bus = DataBus.new()
		if input_pin.data_bus != null: input_pin.data_bus.remove()
	
	output_pin.add_child(new_bus)
	new_bus.create(output_pin, input_pin)
