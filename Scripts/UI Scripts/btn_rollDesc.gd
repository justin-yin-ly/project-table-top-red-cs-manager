extends Btn_RollOpt

@export var desc: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	super()
	desc.textIndex = optBtn.selected
	desc.UpdateText()
