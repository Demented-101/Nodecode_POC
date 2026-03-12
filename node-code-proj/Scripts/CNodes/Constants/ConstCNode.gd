extends CNode
class_name Const_CNode

@export var line_edit:LineEdit
@export var container:Container

func populate_pins() -> void:
	## no inputs
	program.input_count = 0
	
	## setup outputs
	var outputs:Dictionary[String, pinTypes] = program.define_outputs()
	program.output_count = outputs.size()
	
	var output:CNodePin
	if outputs.values()[0] == pinTypes.Exc:
		output = EXC_PIN_OUT.instantiate()
	else:
		output = DATA_PIN_OUT.instantiate()
	add_child(output)
	program.output_pins = [output]
	
	output.position = Vector2(program.definition.width, 40)
	output.setup(outputs.values()[0], self, 0, outputs.keys()[0])

func update_display() -> void:
	var height:int = 80
	var width:int = program.definition.width
	size = Vector2(width, height)
	
	## setup interface
	if program is ConstantProgram: 
		var c_program:ConstantProgram = program as ConstantProgram
		var interface_scene = c_program.define_interface()
		
		if interface_scene != null:
			var interface:Control = interface_scene.instantiate()
			container.add_child(interface)
			interface.interface_value_changed.connect(c_program.set_value)
		else:
			height = 50
			program.output_pins[0].position.y = 25
	
	header.polygon = [ Vector2(width, 0), Vector2(width, height), Vector2(0, height), Vector2(0, 0) ]
	header.uv = [ Vector2(0, height), Vector2(0, 0), Vector2(width, 0), Vector2(width, height) ]
	header.z_index = 1
	
	body.hide()
	
	drag_zone.size.x = width
	title_label.text = program.definition.display_name
	
