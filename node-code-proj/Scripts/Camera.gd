extends Camera2D
class_name NodeEnvironmentCamera

static var instance:NodeEnvironmentCamera

func _ready() -> void:
	if instance != null: self.queue_free()
	instance = self

const scroll_speed:float = 0.1

@export var zoom_min:float = 0.1
@export var zoom_max:float = 5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed(&"R_click"):
		var mouse_motion:InputEventMouseMotion = event as InputEventMouseMotion
		position -= mouse_motion.relative / zoom.x
	
	if event.is_action(&"Scroll_up") and Input.is_action_pressed(&"Scroll_up"): do_zoom(scroll_speed) 
	elif event.is_action(&"Scroll_down") and Input.is_action_pressed(&"Scroll_down"): do_zoom(-scroll_speed)

func do_zoom(direction:float) -> void:
	zoom.x = clampf(zoom.x + direction, zoom_min, zoom_max)
	zoom.y = zoom.x
