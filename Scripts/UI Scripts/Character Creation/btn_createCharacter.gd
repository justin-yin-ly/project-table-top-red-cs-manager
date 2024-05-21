extends Node

var character = load("res://Prefabs/character.tscn")
var charSheet = load("res://UI/characterSheet.tscn")

@export var sceneRoot: Node
@export var charCreator: Node
@export var modal_dialogue: Node

@export var skillGroupsRefs: Array[Node]

# References to the extended education & play instrument skills - for grabbing the custom skill arrays from each
@export var eduExt_language: Node
@export var eduExt_localExp: Node
@export var eduExt_science: Node
@export var subGrp_playInstr: Node

@export var remPointsStats: Node
@export var remPointsSkills: Node
@export var warningLabel: Node

@export var charName_input: Node
@export var roleSelection: Node
@export var stat_Int: Node
@export var stat_Ref: Node
@export var stat_Dex: Node
@export var stat_Tech: Node
@export var stat_Cool: Node
@export var stat_Will: Node
@export var stat_Luck: Node
@export var stat_Move: Node
@export var stat_Body: Node
@export var stat_Emp: Node

# Array for holding references to each of the lifepath fields
@export var lifepath_nodeArray: Array[Node]

# Arrays for generating the keys and values of the role-based lifepath dictionary
var rolePath_keys: Array[Node]
var rolePath_values: Array[Node]
var rolePath_dict = {}
# god forgive me this shit sucks
var roleIndex: int
@export var roleOptions: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	var blankSkill = false
	
	# Initialize the extended education skill arrays and then use them to check for blank/unnamed skills
	eduExt_language.GenerateArrays()
	eduExt_localExp.GenerateArrays()
	eduExt_science.GenerateArrays()
	subGrp_playInstr.GenerateArrays()
	
	var blanks = []
	
	for i in eduExt_language.customData_array.size():
		if(eduExt_language.customData_array[i][1] == ""):
			blanks.append(eduExt_language.customSkill_array[i])
			blankSkill = true

	for i in eduExt_localExp.customData_array.size():
		if(eduExt_localExp.customData_array[i][1] == ""):
			blanks.append(eduExt_localExp.customSkill_array[i])
			blankSkill = true

	for i in eduExt_science.customData_array.size():
		if(eduExt_science.customData_array[i][1] == ""):
			blanks.append(eduExt_science.customSkill_array[i])
			blankSkill = true

	for i in subGrp_playInstr.customData_array.size():
		if(subGrp_playInstr.customData_array[i][1] == ""):
			blanks.append(subGrp_playInstr.customSkill_array[i])
			blankSkill = true

	if(blankSkill):
		# enable the modal dialogue
		modal_dialogue.visible = true
		modal_dialogue.SetTitle("Warning: Unnamed Custom Skill Detected")
		modal_dialogue.SetBody("One or more of the custom skills in the Education+ tab or Performance tab has been left unnamed. These unnamed skills will be removed and any points spent on them will be refunded. (Does not apply to mandatory skills such as your first Langauge skill)")
		for i in blanks.size():
			if(blanks[i].deleteable):
				blanks[i]._on_btn_delete_pressed()
		# exit the function
		return

	if(int(remPointsStats.text) <= 0 && int(remPointsSkills.text) <= 0 && charName_input.text != "" && roleSelection.selected >= 0):
		# Generate arrays in our skill group Nodes
		for i in skillGroupsRefs.size():
			skillGroupsRefs[i].generateLevelArray()
		
		# Set character stats
		var char_instance = character.instantiate()
		char_instance.initializeStats(charName_input.text, roleSelection.selected, 
			int(stat_Int.text), int(stat_Ref.text), int(stat_Dex.text), int(stat_Tech.text), int(stat_Cool.text),
			int(stat_Will.text), int(stat_Luck.text), int(stat_Move.text), int(stat_Body.text), int(stat_Emp.text)
			)
			
		# Initialize skill group level arrays
		for i in skillGroupsRefs.size():
			skillGroupsRefs[i].generateLevelArray()
		
		# Set character skill arrays (why the hell didn't I just use append?)
		char_instance.sklGrp_awareness = skillGroupsRefs[0].levelArray
		char_instance.sklGrp_body = skillGroupsRefs[1].levelArray
		char_instance.sklGrp_control = skillGroupsRefs[2].levelArray
		char_instance.sklGrp_education = skillGroupsRefs[3].levelArray
		char_instance.sklGrp_fighting = skillGroupsRefs[4].levelArray
		char_instance.sklGrp_performance = skillGroupsRefs[5].levelArray
		char_instance.sklGrp_rangedWep = skillGroupsRefs[6].levelArray
		char_instance.sklGrp_social = skillGroupsRefs[7].levelArray
		char_instance.sklGrp_technique = skillGroupsRefs[8].levelArray
		
		# Set character custom skills
		char_instance.subGrp_language = eduExt_language.customData_array
		char_instance.subGrp_localExp = eduExt_localExp.customData_array
		char_instance.subGrp_science = eduExt_science.customData_array
		char_instance.subGrp_playInstr = subGrp_playInstr.customData_array
		
		char_instance.initializeArrayArray()
		
		# Populate lifepath array
		for i in lifepath_nodeArray.size():
			char_instance.lifepath_data.append(lifepath_nodeArray[i].text)
		
		# Set role-based lifepath dictionary
		roleOptions._on_item_selected(roleIndex)
		GenerateRolePath()
		char_instance.roleLifepath_dict = rolePath_dict
		
		# Add character to scene
		sceneRoot.add_child(char_instance)
		# Set new character as active character for sake of saving function
		sceneRoot.activeChar = char_instance
		
		var charSheet_instance = charSheet.instantiate()
		charSheet_instance.charRef = char_instance
		sceneRoot.add_child(charSheet_instance)
		sceneRoot.activeSheet = charSheet_instance
		
		charCreator.visible = !charCreator.visible
	elif(roleSelection.selected <= -1):
		warningLabel.visible = true
		warningLabel.text = "You need to select a Role!"
	elif(int(remPointsStats.text) > 0):
		warningLabel.visible = true
		warningLabel.text = "You still have STAT points remaining!"
	elif(int(remPointsSkills.text) > 0):
		warningLabel.visible = true
		warningLabel.text = "You still have Skill points remaining!"
	elif(charName_input.text == ""):
		warningLabel.visible = true
		warningLabel.text = "You need to give your character a name!"

func GenerateRolePath():
	for i in rolePath_keys.size():
		rolePath_dict[rolePath_keys[i].text] = rolePath_values[i].text
