extends LineEdit

var cast_value:int = 0
signal interface_value_changed(value:int)

func _ready() -> void:
	text_changed.connect(on_changed)
	text = "0"

func on_changed(new_value:String) -> void:
	if !new_value.is_valid_int() and new_value != "":
		text = str(cast_value)
		return
	
	cast_value = new_value.to_int()
	interface_value_changed.emit(cast_value)
