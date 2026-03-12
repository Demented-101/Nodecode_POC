extends Node
class_name CNodeEnvironment

@export var nodes:Node2D
@export var busses:Node2D

static var instance:CNodeEnvironment

const C_NODE = preload("uid://dy4tla84v3wg6")
const C_NODE_CONSTANT = preload("uid://b2rfbamr3qy46")
const C_NODE_OUTPUT = preload("uid://b3ptnofkn36bd")

func _ready() -> void:
	if instance != null: 
		free()
		return
	instance = self

func add_new_CNode(definition:CNodeDefinition) -> void:
	var new_node
	
	match definition.cnode_type:
		0: new_node = C_NODE.instantiate()
		1: new_node = C_NODE_CONSTANT.instantiate()
		2: new_node = C_NODE_OUTPUT.instantiate()
	
	nodes.add_child(new_node)
	
	var new_program = Node.new()
	new_program.script = definition.program_script
	new_program.definition = definition
	
	new_node.set_program(new_program)
	new_node.position = NodeEnvironmentCamera.instance.global_position - (new_node.size / 2)

func add_new_bus(new_bus:CNodeBus) -> void:
	busses.add_child(new_bus)
