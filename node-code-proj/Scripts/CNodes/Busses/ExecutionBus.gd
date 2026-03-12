extends CNodeBus
class_name ExecutionBus

func _ready() -> void:
	color_normal = Color(0.866, 0.339, 0.0, 1.0)
	color_bright = Color(1.0, 0.81, 0.632, 1.0)

func create(_out:CNodePin, _in:CNodePin) -> void:
	output_pin = _out
	input_pin = _in
	output_pin.connected(self)
	input_pin.connected(self)
	
	width = 4
	begin_cap_mode = Line2D.LINE_CAP_ROUND
	end_cap_mode = Line2D.LINE_CAP_ROUND

func run() -> void:
	brightness = 1
	
	input_pin.execute()
	input_pin.exc_icon.modulate.a = 1
	output_pin.exc_icon.modulate.a = 1

func remove() -> void:
	super.remove()
	if self == ExecutionHandler.instance.next:
		ExecutionHandler.instance.next = null

static func check_pin_validity(pinA:CNodePin, pinB:CNodePin) -> bool:
	if pinA == null or pinB == null: return false ## validity check
	if pinA.cnode == pinB.cnode: return false ## cannot be on the same CNode
	if pinA.type != CNode.pinTypes.Exc or pinB.type != CNode.pinTypes.Exc: return false ## must both be exc
	if pinA.get_script() == pinB.get_script(): return false ## two output/input pins cannot connect
	return true
