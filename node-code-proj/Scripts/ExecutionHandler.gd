extends Node
class_name ExecutionHandler

@export var log_label:Label
@export var debug_print:bool

signal execution_started
signal execution_ended
var is_running:bool

var exec_speed:float = 1
var timer:float
var next:ExecutionBus
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
	next = null
	logs = []
	execution_started.emit()

func End_Execution() -> void:
	is_running = false
	next = null
	execution_ended.emit()

func _process(delta: float) -> void:
	if !is_running: return
	
	timer += delta
	if timer >= exec_speed:
		timer = 0
		next.run()

func queue_pin(bus:ExecutionBus) -> void:
	next = bus

func add_log(new_log:String) -> void:
	if debug_print: print("--> ", new_log)
	logs.append(new_log)
	
	if logs.size() > 20: logs.remove_at(0)
	log_label.text = ""
	for i in logs: log_label.text += i + "   <- \n"

func add_error_log(error:CNError) -> void:
	if debug_print: printerr("--> ", error.get_error_string())
	logs.append(error.get_simple_error_string())
	
	if logs.size() > 20: logs.remove_at(0)
	log_label.text = ""
	for i in logs: log_label.text += i + "   <- \n"
