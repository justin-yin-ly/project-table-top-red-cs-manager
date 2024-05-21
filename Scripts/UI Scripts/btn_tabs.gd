"""
This script is for managing different tabs and displaying different information in conjuction with other objects with this script. 
It keeps an array of Nodes and it toggles the visibility of these Nodes on and off when pressed.
Array index 0 is always the object that is intended to be turned visible.

It includes an optional text object reference if you want a block of text to change with the tabs.
"""

extends Node

@export var tabs: Array[Node]
@export var txtRef: Node
@export var txtIndex: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	for i in tabs.size():
		tabs[i].visible = false
	
	tabs[0].visible = true
	
	if(txtRef):
		txtRef.setDesc(txtIndex)
	pass # Replace with function body.
