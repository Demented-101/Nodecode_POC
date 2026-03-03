extends Node
class_name ExecutionHandler

signal execution_started
signal execution_ended
var is_running:bool

signal execute
var exec_speed:float = 0.1
var timer:float

static var instance:ExecutionHandler
func _ready() -> void:
	if instance != null: 
		free()
		return
	instance = self

func Start_Execution() -> void:
	execution_started.emit()
	is_running = true

func End_Execution() -> void:
	execution_ended.emit()
	is_running = false

func _process(delta: float) -> void:
	timer += delta
	if timer >= exec_speed:
		timer = 0
		execute.emit()
