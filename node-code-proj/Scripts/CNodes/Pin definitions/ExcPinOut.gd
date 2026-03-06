extends CNodePin
class_name ExecutionPinOut

var execution_bus:ExecutionBus
var connected_pin:ExecutionPinIn
@export var exc_icon:CanvasItem

func connected(new_bus:CNodeBus) -> void:
	is_connected = true
	execution_bus = new_bus
	connected_pin = new_bus.input_pin
	
	new_bus.Disconnected.connect(disconnected)
	print(connected_pin)

func disconnected(_bus:CNodeBus) -> void:
	if _bus != execution_bus: return ## make sure its the correct data bus
	
	execution_bus = null
	connected_pin = null
	is_connected = false

func execute() -> void:
	if !is_connected: return
	ExecutionHandler.instance.queue_pin(execution_bus)

func _process(delta: float) -> void:
	exc_icon.modulate.a = clampf(exc_icon.modulate.a - (delta * 2), 0, 0.9)

func get_value(depth:int) -> Variant:
	return CNError.new(Const.ErrorType.TypeError, self, depth) ## exc has no return value

func on_clicked() -> void:
	if execution_bus:
		execution_bus.remove()
