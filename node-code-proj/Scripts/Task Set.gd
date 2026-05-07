extends Label

var index:int = 0
@export var tasks:Array[String] = []

@export var next_button:Button
@export var prev_button:Button

func _ready() -> void:
	next_button.pressed.connect(next)
	prev_button.pressed.connect(prev)
	text = tasks[0]

func next() -> void:
	index += 1
	if index >= tasks.size():
		index = tasks.size() - 1
	
	text = tasks[index]

func prev() -> void:
	index -= 1
	if index < 0:
		index = 0
	
	text = tasks[index]
