extends CNodePin
class_name DataPinIn

var data_bus:DataBus
var connected_pin:DataPinOut

func connected(new_bus:CNodeBus) -> void:
	is_connected = true
	data_bus = new_bus
	connected_pin = new_bus.output_pin
	
	new_bus.Disconnected.connect(disconnected)

func disconnected(_bus:CNodeBus) -> void:
	if _bus != data_bus: return ## make sure its the correct data bus
	
	data_bus = null
	connected_pin = null
	is_connected = false

func disconnect_all() -> void:
	if data_bus != null: data_bus.remove()

func get_value(depth:int) -> Variant:
	if type == CNode.pinTypes.Exc: return CNError.new(Const.ErrorType.TypeError, self, depth) ## exc has no return value
	if is_connected: 
		data_bus.brightness = 1
		return connected_pin.get_value(depth)
	
	## define default values
	match type:
		CNode.pinTypes.Bool: return false
		CNode.pinTypes.Int: return 0
		CNode.pinTypes._String: return ""
	
	return CNError.new(Const.ErrorType.TypeError, self, depth)

func on_clicked() -> void:
	if data_bus:
		data_bus.remove()
