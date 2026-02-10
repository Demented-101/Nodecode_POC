extends Node2D
class_name DataBus

var output_pin:CNodePin
var input_pin:CNodePin
var line:Line2D

signal Disconnected(_self:DataBus)

var gradients:Dictionary[CNode.pinTypes, Texture] = {
	CNode.pinTypes.Exc : preload("uid://cshc3blqmgwu3"),
	CNode.pinTypes.Bool : preload("uid://evradaricva"),
	CNode.pinTypes.Int : preload("uid://dtq01u6dywh6x"),
	CNode.pinTypes._String : preload("uid://b7lofff33r0d3")
}

func create(_out:CNodePin, _in:CNodePin) -> void:
	output_pin = _out
	input_pin = _in
	input_pin.connected(self)
	
	line = Line2D.new()
	add_child(line)
	
	line.z_index = 2
	line.width = 4
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	
	line.default_color = Color(0.9,0.9,0.9,0.8)
	line.texture = gradients[output_pin.type]

func remove() -> void:
	Disconnected.emit(self)
	queue_free()

func _process(_delta: float) -> void:
	global_position = Vector2(0,0)
	line.points = [output_pin.global_position, input_pin.global_position]

static func check_pin_validity(pinA:CNodePin, pinB:CNodePin) -> bool:
	if pinA == null or pinB == null: return false ## validity check
	if pinA.cnode == pinB.cnode: return false ## cannot be on the same CNode
	if pinA.type != pinB.type: return false ## must be the same data type
	if pinA.is_output == pinB.is_output: return false ## two output/input pins cannot connect
	
	return true
