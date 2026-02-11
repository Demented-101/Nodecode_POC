extends CNodePin
class_name DataPinOut

var data_buses:Array[DataBus]
var connected_pins:Array[DataPinIn]

func connected(new_bus:DataBus) -> void:
	is_connected = true
	data_buses.append(new_bus)
	connected_pins.append(new_bus.input_pin)
	
	new_bus.Disconnected.connect(disconnected)

func disconnected(_bus:DataBus) -> void:
	if !(_bus in data_buses): return ## not connected to this bus
	
	data_buses.erase(_bus)
	connected_pins.erase(_bus.input_pin)
	if data_buses.size() == 0: is_connected = false
	
	_bus.Disconnected.disconnect(disconnected)

func get_value() -> Variant:
	if !is_connected: return null ## return null if not connected
	return cnode.program.get_output(index)

func on_clicked() -> void: # do nothing when clicked
	pass
