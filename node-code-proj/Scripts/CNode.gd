extends Node2D
class_name CNode

@export var drag_zone:Container

var mouse_hovering:bool = false
var is_dragging:bool = false
var drag_offset:Vector2
static var drag_in_use:bool = false

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
