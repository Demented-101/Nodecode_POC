extends Node

enum ErrorType {
	NoExpectedValue, ## invalid pin that should not exist
	PinValidityError, ## a pin/pins are not valid
	MaxDepth, ## reached max call depth
	CalculationError, ## invalid calculation/process
	ConnectionError, ## no expected input/connection
	TypeError, ## Pin cannot calculate type
}

const allowed_data_depth:int = 100
