extends Node

@export var node_title: Node
@export var node_body: Node
var placeholder_title: String
var placeholder_body: String

# Called when the node enters the scene tree for the first time.
func _ready():
	# Save the placeholder text so we can use it to reset the modal later
	placeholder_title = node_title.text
	placeholder_body = node_body.text
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_dialogue_pressed():
	# Reset the modal text
	SetTitle(placeholder_title)
	SetBody(placeholder_body)
	# Hide the modal
	self.visible = false
	pass # Replace with function body.

func SetTitle(title):
	node_title.text = title

func SetBody(body):
	node_body.text = body
