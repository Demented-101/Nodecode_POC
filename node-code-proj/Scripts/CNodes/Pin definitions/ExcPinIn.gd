extends CNodePin
class_name ExecutionPinIn

var execution_buses:Array[ExecutionBus] = []
var connected_pins:Array[ExecutionPinOut] = []
@export var exc_icon:CanvasItem

func connected(new_bus:CNodeBus) -> void:
	is_connected = true
	execution_buses.append(new_bus)
	connected_pins.append(new_bus.output_pin)
	
	new_bus.Disconnected.connect(disconnected)

func disconnected(_bus:CNodeBus) -> void:
	if !(_bus in execution_buses): return ## not connected to this bus
	
	execution_buses.erase(_bus)
	connected_pins.erase(_bus.output_pin)
	if execution_buses.size() == 0: is_connected = false
	
	_bus.Disconnected.disconnect(disconnected)

func execute() -> void:
	cnode.program.execute(pin_name)

func _process(delta: float) -> void:
	exc_icon.modulate.a = clampf(exc_icon.modulate.a - (delta * 2), 0, 0.9)

func get_value(depth:int) -> Variant:
	return CNError.new(Const.ErrorType.TypeError, self, depth)

func on_clicked() -> void:
	pass
