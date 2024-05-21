extends Node

@export var btn_createChar: Node
@export var sceneRoot: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	btn_createChar.sceneRoot = sceneRoot
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
