extends statAllo

var manager: Node
@export var deleteable: bool = true
@export var delBtn_ref: Node
@export var optBtn_ref: Node
@export var nameInput: Node
@export var statSelection: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	if (deleteable == false):
		delBtn_ref.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_btn_delete_pressed():
	remPointsRef.text = str(int(remPointsRef.text) + int(statRef.text))
	manager.customSkill_array.remove_at(manager.customSkill_array.find(self))
	manager.OrganizeSkills()
	queue_free()
	pass # Replace with function body.
