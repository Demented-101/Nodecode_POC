extends Button

signal interface_value_changed(value:bool)

func _pressed() -> void:
	interface_value_changed.emit(CNError.new(Const.ErrorType.NoExpectedValue, self, -1))
