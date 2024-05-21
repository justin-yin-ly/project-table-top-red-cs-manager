extends Node

var customSkill = load("res://UI/skill_custom.tscn")
@export var remPoints_ref: Node
@export var defaultSTAT: int
@export var customSkill_array: Array[Node] 
var customData_array: Array[Array]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func OrganizeSkills():
	var yOffset = 0
	
	for i in customSkill_array.size():
		customSkill_array[i].position = Vector2(-220, -42 + yOffset)
		yOffset += 50

func _on_add_skill_pressed():
	var customSkill_instance = customSkill.instantiate()
	customSkill_instance.remPointsRef = remPoints_ref
	customSkill_instance.manager = self
	customSkill_instance.statSelection.selected = defaultSTAT
	customSkill_array.append(customSkill_instance)
	add_child(customSkill_instance)
	OrganizeSkills()
	pass # Replace with function body.

func GenerateArrays():
	# In case we accidentally call this function more than once, this makes sure our arrays are properly set
	customData_array.clear()
	
	for i in customSkill_array.size():
		var newCSkill = [
			# Skill Level
			int(customSkill_array[i].statRef.text), 
			
			# Skill Name
			customSkill_array[i].nameInput.text, 
			
			# STAT index
			customSkill_array[i].statSelection.selected
			]
		customData_array.append(newCSkill)
