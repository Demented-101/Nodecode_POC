extends CNode
class_name Output_CNode

@export var output_label:Label

func populate_pins() -> void:
	## no outputs
	program.output_count = 0
	
	## setup outputs
	var inputs:Dictionary[String, pinTypes] = program.define_inputs()
	program.input_count = inputs.size()
	
	var input:DataPinIn = DATA_PIN_IN.instantiate()
	add_child(input)
	program.input_pins = [input]
	
	input.position = Vector2(0, 37)
	input.setup(inputs.values()[0], self, 0, inputs.keys()[0])

func update_display() -> void:
	var height:int = 80
	var width:int = program.definition.width
	size = Vector2(width, height)
	
	header.polygon = [ Vector2(width, 0), Vector2(width, 80), Vector2(0, 80), Vector2(0, 0) ]
	header.uv = [ Vector2(0, 08), Vector2(0, 0), Vector2(width, 0), Vector2(width, 80) ]
	header.z_index = 1
	
	body.hide()
	
	drag_zone.size.x = width
	title_label.text = program.definition.display_name
	
	if program is OutputProgram:
		var out_program:OutputProgram = program as OutputProgram
		out_program.output_label = output_label
