extends Node
class_name ExecutionHandler

@export var log_label:Label

signal execution_started
signal execution_ended
var is_running:bool

var exec_speed:float = 1
var timer:float
var queue:Array[ExecutionBus]
var logs:Array[String] = []

static var instance:ExecutionHandler
func _ready() -> void:
	if instance != null: 
		free()
		return
	instance = self

func Start_Execution() -> void:
	timer = 0
	is_running = true
	queue = []
	logs = []
	execution_started.emit()

func End_Execution() -> void:
	is_running = false
	queue = []
	execution_ended.emit()

func _process(delta: float) -> void:
	if !is_running: return
	
	timer += delta
	if timer >= exec_speed:
		timer = 0
		
		var queue_clone = queue.duplicate(false)
		queue = []
		for i in queue_clone: i.run() 

func queue_pin(bus:ExecutionBus) -> void:
	queue.append(bus)

func add_log(new_log:String) -> void:
	logs.append(new_log)
	if logs.size() > 20: logs.remove_at(0)
	
	log_label.text = ""
	for i in logs: log_label.text += i + "   <- \n"
