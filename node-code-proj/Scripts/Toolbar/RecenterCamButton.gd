extends Button

func _pressed() -> void:
	NodeEnvironmentCamera.instance.position = Vector2(0,0)
