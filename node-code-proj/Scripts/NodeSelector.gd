extends Button

@export var nodes:Array[String]
@export var popup:PopupMenu

func _ready() -> void:
	for i in nodes:
		popup.add_item(i)
	
	popup.index_pressed.connect(node_selected)

func _pressed() -> void:
	popup.popup(Rect2(get_global_mouse_position().x, get_global_mouse_position().y, popup.size.x, popup.size.y))

func node_selected(index:int) -> void:
	print(nodes[index])
