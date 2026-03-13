extends RefCounted
class_name CNError

var type:Const.ErrorType
var type_str:String
var origin:Node
var origin_depth:int

const descriptions:Dictionary[Const.ErrorType, String] = {
	Const.ErrorType.NoExpectedValue: "No expected value - internal issue",
	Const.ErrorType.MaxDepth: "Max depth reached - is there a loop somewhere?",
	Const.ErrorType.BeginningError: "Can only have one instance of the beginning!"
}

func _init(err_type:Const.ErrorType, err_origin:Node = null, err_depth:int = -1):
	type = err_type
	type_str = Const.ErrorType.keys()[err_type]
	
	origin = err_origin
	origin_depth = err_depth

func get_error_string() -> String:
	return "Error type: {0} Origin: {1} Depth: {2}".format([
		str(Const.ErrorType.keys()[type]), str(origin), str(origin_depth)
	])

func get_simple_error_string() -> String:
	var prefix:String = "Error type: " + str( Const.ErrorType.keys()[type] )
	if type in descriptions.keys():
		return "{0} - {1}".format(
			[prefix, descriptions[type]]
		) 
	
	return prefix
