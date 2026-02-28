extends Resource
class_name CNodeDefinition

@export var display_name:String
@export var width:int

@export var program_script:Script
@export_enum("Base", "Constant", "Output") var cnode_type:int
