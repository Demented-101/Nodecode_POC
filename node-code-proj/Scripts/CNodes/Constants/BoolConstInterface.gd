extends CheckButton

signal interface_value_changed(value:bool)

func _ready() -> void:
	toggled.connect(on_changed)
	text = "False"

func on_changed(new_value:bool) -> void:
	text = "True" if new_value else "False"
	interface_value_changed.emit(new_value)
