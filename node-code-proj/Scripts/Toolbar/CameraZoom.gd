extends HSlider

@export var reset_button:Button
var cam : NodeEnvironmentCamera

func _ready() -> void:
	cam = NodeEnvironmentCamera.instance
	
	drag_started.connect(func(): cam.zoom_locked = true)
	drag_ended.connect(func(_changed): cam.zoom_locked = false)
	reset_button.pressed.connect(func(): cam.zoom = Vector2(1,1))

func _process(_delta: float) -> void:
	if cam.zoom_locked: ## using button - button controls zoom
		cam.zoom = Vector2(1,1) * lerp(cam.zoom_min, cam.zoom_max, value)
			
	else: ## using camera - scroll controls zoom
		value = inverse_lerp(cam.zoom_min, cam.zoom_max, cam.zoom.x)
