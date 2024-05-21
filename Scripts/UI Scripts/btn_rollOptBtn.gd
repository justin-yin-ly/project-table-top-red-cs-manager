extends Node

class_name Btn_RollOpt

@export var optBtn: Node
@export var genFuncs: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	optBtn.selected = genFuncs.roll_d(optBtn.item_count) - 1
	pass # Replace with function body.
