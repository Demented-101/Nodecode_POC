extends Node2D
class_name DataBus

@export var input_pin:DataPin
@export var output_pin:DataPin

func get_value() -> Variant:
	if !is_valid(): ## if the connection is invalid, remove itself
		queue_free()
		hide()
		return null
	
	return output_pin.get_value()

func is_valid() -> bool: ## both pins are valid
	if input_pin == null or output_pin == null: return false
	return true
