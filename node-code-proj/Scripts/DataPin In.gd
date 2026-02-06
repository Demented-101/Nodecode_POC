extends Sprite2D
class_name DataPinIn

var type:CNode.pinTypes
var data_bus:DataBus = null

func get_value() -> Variant:
	if data_bus != null:
		return data_bus.get_value()
	
	## define default values
	match type:
		CNode.pinTypes._Bool: 
			return false
		CNode.pinTypes._Int, CNode.pinTypes._Float, CNode.pinTypes.Variant_Num:
			return 0
		CNode.pinTypes._String:
			return ""
	
	return null
