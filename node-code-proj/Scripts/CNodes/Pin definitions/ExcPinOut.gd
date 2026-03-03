extends CNodePin
class_name ExecutionPinOut

var execution_bus:ExecutionBus
var connected_pin:DataPinOut
@export var exc_icon:CanvasItem

func connected(new_bus:CNodeBus) -> void:
	is_connected = true
	execution_bus = new_bus
	connected_pin = new_bus.output_pin
	
	new_bus.Disconnected.connect(disconnected)

func disconnected(_bus:CNodeBus) -> void:
	if _bus != execution_bus: return ## make sure its the correct data bus
	
	execution_bus = null
	connected_pin = null
	is_connected = false

func get_value(depth:int) -> Variant:
	if type == CNode.pinTypes.Exc: return CNError.new(Const.ErrorType.TypeError, self, depth) ## exc has no return value
	if is_connected: return connected_pin.get_value(depth)
	
	## define default values
	match type:
		CNode.pinTypes.Bool: return false
		CNode.pinTypes.Int: return 0
		CNode.pinTypes._String: return ""
	
	return CNError.new(Const.ErrorType.TypeError, self, depth)

func on_clicked() -> void:
	if execution_bus:
		execution_bus.remove()
