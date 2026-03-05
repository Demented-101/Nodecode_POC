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
	
	var output:DataPinOut = DATA_PIN_OUT.instantiate()
	add_child(output)
	program.output_pins = [output]
	
	output.position = Vector2(program.definition.width, 37)
	output.setup(outputs.values()[0], self, 0, output.keys()[0])

func update_display() -> void:
	var width:int = program.definition.width
	
	header.polygon = [
		Vector2(width, 0), Vector2(width, 80), Vector2(0, 80), Vector2(0, 0)
	]
	header.uv = [
		Vector2(0, 08), Vector2(0, 0), Vector2(width, 0), Vector2(width, 80)
	]
	
	body.hide()
	
	drag_zone.size.x = width
	title_label.text = program.definition.display_name
	
	## setup interface
	if program is ConstantProgram: 
		var c_program:ConstantProgram = program as ConstantProgram
		var interface:Control = c_program.define_interface().instantiate()
		container.add_child(interface)
		
		interface.interface_value_changed.connect(c_program.set_value)
	
