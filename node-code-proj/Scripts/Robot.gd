extends Node3D
class_name Robot

enum directions {Forward, Right, Backward, Left}
var current_direction:directions

static var instance:Robot
func _ready() -> void:
	if instance != null:
		queue_free()
		return
	instance = self
	
	ExecutionHandler.instance.execution_started.connect(func(): 
		position = Vector3.ZERO
		look_at(Vector3(0,0,-1))
	)

func move(direction:int = 0) -> void:
	var forward_vector:Vector3
	match direction:
		0: forward_vector = -basis.z ## forward
		1: forward_vector = basis.x ## right
		2: forward_vector = basis.z ## back
		3: forward_vector = -basis.x ## left
	forward_vector = forward_vector.normalized() * 2
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + forward_vector, 0.08)

func face(direction:int) -> void:
	var forward_vector:Vector3
	match direction:
		0: forward_vector = Vector3(0,0,-1)
		1: forward_vector = Vector3(1,0,0)
		2: forward_vector = Vector3(0,0,1)
		3: forward_vector = Vector3(-1,0,0)
	
	look_at(position + forward_vector)
	current_direction = direction as directions

func turn(left:bool) -> void:
	var forward_vector:Vector3 = basis.x
	if left: 
		look_at(position + (forward_vector * -1))
		current_direction = (current_direction - 1) % 4 as directions
		if current_direction < 0: current_direction += 4
	else: 
		look_at(position + forward_vector)
		current_direction = (current_direction + 1) % 4 as directions

func get_direction() -> directions:
	return current_direction
