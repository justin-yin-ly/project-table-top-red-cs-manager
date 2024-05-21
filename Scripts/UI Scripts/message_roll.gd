extends Node

var skillName: String
var skillLevel: int
var stat: String
var statValue: int
var dieResult: int
var critState = 0
var critResult = 0
var colorCode = "[color=white]"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func GenerateMessage():
	var message = "Rolling " + skillName + " skill: 
	Skill Level (" + str(skillLevel) + ") + " + stat + " (" + str(statValue) + ")  
	+ 1d10 (" + str(dieResult) + ")"
	
	match critState:
		1:
			colorCode = "[color=green]"
			message += " + Critical success! (" + str(critResult) + ")"
		2:
			colorCode = "[color=red]"
			message += " - Critical failure! (" + str(critResult) + ")"
	
	message += "
	Result: " + colorCode + str(skillLevel + statValue + dieResult + critResult) + "[/color]"
	
	self.text = message
