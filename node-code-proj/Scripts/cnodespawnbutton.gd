extends Button

@export var program_script:Script
const C_NODE = preload("uid://dy4tla84v3wg6")

func _pressed() -> void:
	var new_node = C_NODE.instantiate()
	get_parent().add_child(new_node)
	
	var new_program = Node.new()
	new_program.script = program_script
	
	new_node.set_program(new_program)
