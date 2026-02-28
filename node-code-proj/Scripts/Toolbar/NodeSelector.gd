extends Button

@export var nodes:Array[CNodeDefinition]
@export var popup:PopupMenu

const C_NODE = preload("uid://dy4tla84v3wg6")
const C_NODE_CONSTANT = preload("uid://b2rfbamr3qy46")
const C_NODE_OUTPUT = preload("uid://b3ptnofkn36bd")

func _ready() -> void:
	for i in nodes:
		popup.add_item(i.display_name)
	
	popup.index_pressed.connect(node_selected)

func _pressed() -> void:
	popup.popup(Rect2(get_global_mouse_position().x, get_global_mouse_position().y, popup.size.x, popup.size.y))

func node_selected(index:int) -> void:
	var definition:CNodeDefinition = nodes[index]
	var new_node
	
	match definition.cnode_type:
		0: new_node = C_NODE.instantiate()
		1: new_node = C_NODE_CONSTANT.instantiate()
		2: new_node = C_NODE_OUTPUT.instantiate()
	
	CNodeEnvironment.instance.add_sibling(new_node)
	var new_program = Node.new()
	new_program.script = definition.program_script
	
	new_node.set_program(new_program)
