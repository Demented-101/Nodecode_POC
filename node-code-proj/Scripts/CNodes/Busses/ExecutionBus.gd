extends CNodeBus
class_name ExecutionBus

func create(_out:CNodePin, _in:CNodePin) -> void:
	output_pin = _out
	output_pin.connected(self)
	input_pin = _in
	input_pin.connected(self)
	
	z_index = 2
	width = 4
	begin_cap_mode = Line2D.LINE_CAP_ROUND
	end_cap_mode = Line2D.LINE_CAP_ROUND
	
	default_color = Color(0.9,0.2,0.1,0.8)
	texture = gradients[output_pin.type]

static func check_pin_validity(pinA:CNodePin, pinB:CNodePin) -> bool:
	if pinA == null or pinB == null: return false ## validity check
	if pinA.cnode == pinB.cnode: return false ## cannot be on the same CNode
	if pinA.type == CNode.pinTypes.Exc and pinB.type == CNode.pinTypes.Exc: return false ## must both be exc
	if pinA.get_script() == pinB.get_script(): return false ## two output/input pins cannot connect
	
	return true
