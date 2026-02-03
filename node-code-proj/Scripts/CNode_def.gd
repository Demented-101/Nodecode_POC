extends Resource
class_name CNodeDef

enum pinTypes {_Bool, _Int, _Float, _String}

@export var name:String

@export var has_execute_pin:bool
@export var left_pins:Dictionary[pinTypes, String]
@export var right_pins:Dictionary[pinTypes, String]
