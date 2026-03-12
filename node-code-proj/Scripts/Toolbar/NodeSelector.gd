extends Button

@export var nodes:Array[CNodeDefinition]
@export var popup:PopupMenu

const C_NODE = preload("uid://dy4tla84v3wg6")
const C_NODE_CONSTANT = preload("uid://b2rfbamr3qy46")
const C_NODE_OUTPUT = preload("uid://b3ptnofkn36bd")

func _ready() -> void:
	for i in nodes:
		popup.add_item(i.display_name)
	
	popup.index_pressed.connect(func(index): CNodeEnvironment.instance.add_new_CNode(nodes[index]))

func _pressed() -> void:
	popup.popup(Rect2(get_global_mouse_position().x, get_global_mouse_position().y, popup.size.x, popup.size.y))
