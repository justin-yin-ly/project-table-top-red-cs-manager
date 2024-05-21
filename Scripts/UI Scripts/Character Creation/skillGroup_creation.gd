extends Node

@export var skillRefs: Array[Node]
@export var levelArray: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generateLevelArray():
	for i in skillRefs.size():
		levelArray.append(int(skillRefs[i].statRef.text))
