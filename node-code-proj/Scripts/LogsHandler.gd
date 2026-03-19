extends RichTextLabel
class_name LogsHandler

@export var debug_print:bool
@export var scroll_container:ScrollContainer

static var instance:LogsHandler
func _ready() -> void:
	if instance != null:
		free()
		return
	instance = self

func clear_logs():
	clear()
	text = ""

func add_log(new_log:String) -> void:
	if debug_print: print("--> ", new_log)
	append_text("   --> " + new_log + "\n")

func add_command_log(new_log:String) -> void:
	if debug_print: print("COMMAND - " + new_log)
	append_text("[color=Dimgray]" + new_log + "[/color]\n")

func add_error_log(error:CNError) -> void:
	if debug_print: printerr("!-> ", error.get_error_string())
	append_text("[color=red]   !-> " + error.get_simple_error_string() + "[/color]\n")
