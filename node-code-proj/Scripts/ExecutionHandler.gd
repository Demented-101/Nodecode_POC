extends Node
class_name ExecutionHandler

@export var start_button:Button
@export var stop_button:Button
@export var pause_button:Button
@export var speed_slider:Slider

signal execution_started
signal execution_ended
var is_running:bool

enum ExecutionStates {Stopped, Running, Paused}
var current_state:ExecutionStates = ExecutionStates.Stopped

var exec_speed:float = 0.45
var timer:float
var next:ExecutionBus
var return_queue:Array[CNodeProgram]

static var instance:ExecutionHandler
func _ready() -> void:
	if instance != null: 
		free()
		return
	instance = self
	
	start_button.pressed.connect(start_execution)
	pause_button.pressed.connect(pause_execution)
	stop_button.pressed.connect(end_execution)

func start_execution() -> void:
	timer = 0
	is_running = true
	if current_state == ExecutionStates.Stopped:
		execution_started.emit()
	current_state = ExecutionStates.Running
	
	start_button.disabled = true
	pause_button.disabled = false
	stop_button.disabled = false

func pause_execution() -> void:
	timer = 0
	is_running = false
	current_state = ExecutionStates.Paused
	
	start_button.disabled = false
	pause_button.disabled = true
	stop_button.disabled = false

func end_execution() -> void:
	is_running = false
	next = null
	current_state = ExecutionStates.Stopped
	execution_ended.emit()
	LogsHandler.instance.clear()
	
	start_button.disabled = false
	pause_button.disabled = true
	stop_button.disabled = true

func queue_pin(bus:ExecutionBus) -> void: ## set next exc line to execute
	if !is_running: return
	next = bus

func queue_as_return(program:CNodeProgram) -> void: ## add program to the return queue
	if !is_running: return
	return_queue.append(program)

func _process(delta: float) -> void:
	exec_speed = 1 - speed_slider.value
	if !is_running: return
	
	timer += delta
	if timer >= exec_speed:
		timer = 0
		if next != null: execute_next()
		else: return_back()

func execute_next() -> void:
	var to_run = next
	next = null
	to_run.run()

func return_back() -> void: 
	if return_queue.size() < 1:
		end_execution()
		return
	
	var return_point := return_queue[-1]
	return_point.execute("_Returned")
	return_queue.erase(return_point)
