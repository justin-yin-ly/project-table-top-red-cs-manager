extends Node
@export var textIndex: int
@export var textArray: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func UpdateText():
	self.text = textArray[textIndex]

# For when you need to hook up this descrition to an OptionButton
func _on_option_button_item_selected(index):
	textIndex = index
	UpdateText()
	pass # Replace with function body.
