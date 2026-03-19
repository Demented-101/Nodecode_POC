extends Node3D
class_name Robot

enum directions {Forward, Right, Backward, Left}
static var instance:Robot

func _ready() -> void:
	if instance != null:
		queue_free()
		return
	instance = self
	
	ExecutionHandler.instance.execution_started.connect(func(): position = Vector3.ZERO)

func move_forward() -> void:
	var forward_vector = -basis.z
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + forward_vector, 0.08)
