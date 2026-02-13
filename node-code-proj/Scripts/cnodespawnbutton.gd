extends Button

@export var program_script:Script
@export_enum("Base", "Constant", "Output") var cnode_type:int

const C_NODE = preload("uid://dy4tla84v3wg6")
const C_NODE_CONSTANT = preload("uid://b2rfbamr3qy46")
const C_NODE_OUTPUT = preload("uid://b3ptnofkn36bd")


func _pressed() -> void:
	var new_node
	
	match cnode_type:
		0: new_node = C_NODE.instantiate()
		1: new_node = C_NODE_CONSTANT.instantiate()
		2: new_node = C_NODE_OUTPUT.instantiate()
	
	get_parent().add_child(new_node)
	
	var new_program = Node.new()
	new_program.script = program_script
	
	new_node.set_program(new_program)
