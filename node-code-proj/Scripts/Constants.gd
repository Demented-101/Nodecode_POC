extends Node

enum ErrorType {
	NoExpectedValue, ## invalid pin that should not exist
	PinValidityError, ## a pin/pins are not valid
	MaxDepth, ## reached max call depth
	CalculationError, ## invalid calculation/process
	ConnectionError, ## no expected input/connection
	TypeError, ## Pin cannot calculate type
	BeginningError, ## Cannot spawn new beginning, already exists
	NoAnyTypeValue, ## DataAny pin doesnt have a current value
}

const allowed_data_depth:int = 100

func data_to_string(value:Variant, type:CNode.pinTypes) -> String:
	match type:
		CNode.pinTypes.Bool: return "True" if value else "False"
		CNode.pinTypes.Direction: return ["Forward", "Right", "Backward", "Left"][value]
	
	return str(value)
