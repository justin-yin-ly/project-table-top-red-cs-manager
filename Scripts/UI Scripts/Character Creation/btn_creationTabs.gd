extends Node

@export var tab_Role: Node
@export var tab_Stats: Node
@export var tab_Skills: Node
@export var tab_Lifepath: Node

@export var tab_Visible: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	tab_Role.visible = false
	tab_Stats.visible = false
	tab_Skills.visible = false
	tab_Lifepath.visible = false
	tab_Visible.visible = true
	pass # Replace with function body.
