extends OptionButton

signal interface_value_changed(value:bool)
const options_order:Array[Robot.directions] = [
	Robot.directions.Forward,
	Robot.directions.Right,
	Robot.directions.Backward,
	Robot.directions.Left
]

func _ready() -> void:
	item_selected.connect(on_changed)

func on_changed(new_value:int) -> void:
	interface_value_changed.emit(options_order[new_value])
