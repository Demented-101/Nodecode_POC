extends Label
class_name LogsHandler

@export var debug_print:bool

const max_logs:int = 25
var logs:Array[String] = []

static var instance:LogsHandler
func _ready() -> void:
	if instance != null:
		free()
		return
	instance = self

func clear() -> void:
	logs = []

func add_log(new_log:String) -> void:
	if debug_print: print("--> ", new_log)
	logs.append(new_log)
	update_text()

func add_error_log(error:CNError) -> void:
	if debug_print: printerr("--> ", error.get_error_string())
	logs.append(error.get_simple_error_string())
	update_text()

func update_text() -> void:
	if logs.size() > 20: logs.remove_at(0)
	text = ""
	for i in logs: text += i + "   <- \n"
	
