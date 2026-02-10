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
	if instance != null: queue_free()
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
	var do_show:bool = (pin.global_position - get_viewport().get_mouse_position()).length() > 10
	var target_position:Vector2 = hovered_pin.global_position if hovered_pin != null else get_viewport().get_mouse_position()
	
	line.visible = do_show
	line.points = [pin.global_position, target_position]

func end_drag() -> void:
	if !is_dragging: return
	
	is_dragging = false
	line.queue_free()
	pin.z_index = 0
	click_timer = 0
	
	if DataBus.check_pin_validity(pin, hovered_pin):
		var new_bus = DataBus.new()
		
		if pin.is_output: 
			pin.cnode.add_child(new_bus)
			new_bus.create(pin, hovered_pin)
		else: 
			hovered_pin.cnode.add_child(new_bus)
			new_bus.create(hovered_pin, pin)

func pin_hovered(target_pin:CNodePin) -> void:
	hovered_pin = target_pin

func pin_hover_ended(target_pin:CNodePin) -> void:
	if hovered_pin == target_pin: hovered_pin = null
