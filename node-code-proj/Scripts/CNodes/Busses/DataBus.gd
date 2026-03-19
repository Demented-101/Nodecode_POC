extends CNodeBus
class_name DataBus

func _ready() -> void:
	color_normal = Color(0.5,0.5,0.5)
	color_bright = Color(1,1,1)

func create(_out:CNodePin, _in:CNodePin) -> void:
	output_pin = _out
	output_pin.connected(self)
	input_pin = _in
	input_pin.connected(self)
	
	width = 4
	begin_cap_mode = Line2D.LINE_CAP_ROUND
	end_cap_mode = Line2D.LINE_CAP_ROUND
	
	if output_pin.type == CNode.pinTypes.DataAny:
		texture = gradients[input_pin.type]
	else:
		texture = gradients[output_pin.type]

static func check_pin_validity(pinA:CNodePin, pinB:CNodePin) -> bool:
	if pinA == null or pinB == null: return false ## validity check
	if pinA.cnode == pinB.cnode: return false ## cannot be on the same CNode
	if pinA.type == CNode.pinTypes.Exc: return false ## cannot be execute
	if pinA.get_script() == pinB.get_script(): return false ## two output/input pins cannot connect
	if pinA.type == CNode.pinTypes.Exc or pinB.type == CNode.pinTypes.Exc: return false ## no EXC pins
	
	## connect to same type or any
	var has_any:bool = pinA.type == CNode.pinTypes.DataAny or pinB.type == CNode.pinTypes.DataAny
	if !has_any and pinA.type != pinB.type: return false 
	
	return true
