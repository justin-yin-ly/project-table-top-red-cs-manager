extends Node

# For instantiating custom skills - the others are hardcoded onto the sheet at the moment
var instRef_skill = load("res://UI/skill.tscn")

# Reference to specific character
@export var charRef: Node

# References to various skill groups
@export var sklGrp_awareness: Array[Node]
@export var sklGrp_body: Array[Node]
@export var sklGrp_control: Array[Node]
@export var sklGrp_education: Array[Node]
@export var sklGrp_fighting: Array[Node]
@export var sklGrp_performance: Array[Node]
@export var sklGrp_rangedWep: Array[Node]
@export var sklGrp_social: Array[Node]
@export var sklGrp_technique: Array[Node]

# Holds all nodes so that we can get skills by name by checking the text of the node
var sklGrp_all = []

# Reference to custom skill groups for handling the proper appending of the custom skills as child nodes
@export var node_sklGrp_extEdu: Node
@export var node_sklGrp_performance: Node

# References to labels that are supposed to display stats numerically
@export var statLabel_Int: Node
@export var statLabel_Ref: Node
@export var statLabel_Dex: Node
@export var statLabel_Tech: Node
@export var statLabel_Cool: Node
@export var statLabel_Will: Node
@export var statLabel_Luck: Node
@export var statLabel_Move: Node
@export var statLabel_Body: Node
@export var statLabel_Emp: Node

# References to labels that are supposed to display additional character info (i.e. hit points, cash, serious wound threshold)
@export var infoLabel_HitPoints: Node
@export var infoLabel_CharName: Node
@export var infoLabel_CharRole: Node
@export var infoLabel_Humanity: Node
@export var infoLabel_DeathSave: Node
@export var infoLabel_SerWoundThreshold: Node
@export var input_Cash: Node
@export var input_ImpPoints: Node
@export var input_ImpPointsLT: Node

# Lifepath label array for displaying lifepath info
@export var lifepath_nodeArray: Array[Node]

# Role-based lifepath references
@export var rolePath: Node
var lifePath_section = load("res://UI/lifepath_section.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	load_sheet()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# This is separated into its own function since we'll likely need to keep updating the hit points display; 
# this way, we can call on it whenever the value changes via signals 
# (note: still figuring out what that means, but as I understand it, 
# you can trigger function calls when certain things happen, like a character taking damage)
func displayHitPoints():
	if(charRef):
		infoLabel_HitPoints.text = str(charRef.hitPoints_cur) + " / " + str(charRef.hitPoints_max)

# Displaying humanity put into its own function for the same reasons as putting hit points display in its own function
# This is a value that changes every now and again, so having a separate function makes it easy to update the display whenever we need to
func displayHumanity():
	if(charRef):
		infoLabel_Humanity.text = str(charRef.humanity_cur) + " / " + str(charRef.humanity_max)
		
# Again, same argument as the hitPoints and humanity labels for Improvement Points
func displayImpPoints():
	if(charRef):
		input_ImpPoints.value = charRef.impPoints_cur
		input_ImpPointsLT.value = charRef.impPoints_lifetime

# Whenever there's a change in the character's stats or skill levels, we call this function to set the values accordingly
func initializeAllSkillGroups():
	initializeOneSkillGroup(sklGrp_awareness)
	initializeOneSkillGroup(sklGrp_body)
	initializeOneSkillGroup(sklGrp_control)
	initializeOneSkillGroup(sklGrp_education)
	initializeOneSkillGroup(sklGrp_performance)
	initializeOneSkillGroup(sklGrp_fighting)
	initializeOneSkillGroup(sklGrp_rangedWep)
	initializeOneSkillGroup(sklGrp_social)
	initializeOneSkillGroup(sklGrp_technique)
	
func initializeOneSkillGroup(sklGrp):
		for i in sklGrp.size():
			sklGrp[i].charRef = charRef
			sklGrp[i].initializeSkill()

func initializeCompoundedGroup():
	sklGrp_all.clear()
	sklGrp_all.append(sklGrp_awareness)
	sklGrp_all.append(sklGrp_body)
	sklGrp_all.append(sklGrp_control)
	sklGrp_all.append(sklGrp_education)
	sklGrp_all.append(sklGrp_fighting)
	sklGrp_all.append(sklGrp_performance)
	sklGrp_all.append(sklGrp_rangedWep)
	sklGrp_all.append(sklGrp_social)
	sklGrp_all.append(sklGrp_technique)

func generateCustomSkills():
	var yOffset = 0
	
	for i in node_sklGrp_extEdu.get_node("branch_language").get_children():
		i.free()
	
	for i in node_sklGrp_extEdu.get_node("branch_localExp").get_children():
		i.free()

	for i in node_sklGrp_extEdu.get_node("branch_science").get_children():
		i.free()

	for i in node_sklGrp_performance.get_node("branch_playInstr").get_children():
		i.free()

	for i in charRef.subGrp_language.size():
		var customSkill_instance = instRef_skill.instantiate()
		customSkill_instance.skillLevelNum = charRef.subGrp_language[i][0]
		customSkill_instance.text = charRef.subGrp_language[i][1]
		customSkill_instance.statIndex = charRef.subGrp_language[i][2]
		customSkill_instance.charRef = charRef
		customSkill_instance.initializeSkill()
		node_sklGrp_extEdu.get_node("branch_language").add_child(customSkill_instance)
		customSkill_instance.position = Vector2(-285, 35 + yOffset)
		yOffset += 150

	yOffset = 0
	for i in charRef.subGrp_localExp.size():
		var customSkill_instance = instRef_skill.instantiate()
		customSkill_instance.skillLevelNum = charRef.subGrp_localExp[i][0]
		customSkill_instance.text = charRef.subGrp_localExp[i][1]
		customSkill_instance.statIndex = charRef.subGrp_localExp[i][2]
		customSkill_instance.charRef = charRef
		customSkill_instance.initializeSkill()
		node_sklGrp_extEdu.get_node("branch_localExp").add_child(customSkill_instance)
		customSkill_instance.position = Vector2(-60, 35 + yOffset)
		yOffset += 150

	yOffset = 0
	for i in charRef.subGrp_science.size():
		var customSkill_instance = instRef_skill.instantiate()
		customSkill_instance.skillLevelNum = charRef.subGrp_science[i][0]
		customSkill_instance.text = charRef.subGrp_science[i][1]
		customSkill_instance.statIndex = charRef.subGrp_science[i][2]
		customSkill_instance.charRef = charRef
		customSkill_instance.initializeSkill()
		node_sklGrp_extEdu.get_node("branch_science").add_child(customSkill_instance)
		customSkill_instance.position = Vector2(165, 35 + yOffset)
		yOffset += 150

	var xOffset = -60 * charRef.subGrp_playInstr.size()
	for i in charRef.subGrp_playInstr.size():
		var customSkill_instance = instRef_skill.instantiate()
		customSkill_instance.skillLevelNum = charRef.subGrp_playInstr[i][0]
		customSkill_instance.text = charRef.subGrp_playInstr[i][1]
		customSkill_instance.statIndex = charRef.subGrp_playInstr[i][2]
		customSkill_instance.charRef = charRef
		customSkill_instance.initializeSkill()
		node_sklGrp_performance.get_node("branch_playInstr").add_child(customSkill_instance)
		customSkill_instance.position = Vector2(xOffset,180)
		xOffset += 120

func displayLifePath():
	for i in lifepath_nodeArray.size():
		lifepath_nodeArray[i].text = charRef.lifepath_data[i]

func displayRolePath():
	var dictKeys = charRef.roleLifepath_dict.keys()
	var column = 1
	var yOffset = 0
	
	for i in rolePath.get_node("branch_labels").get_children():
		i.free()
	
	for i in dictKeys.size():
		var rolePath_instance = lifePath_section.instantiate()
		rolePath_instance.text = dictKeys[i]
		rolePath_instance.sectionText.text = charRef.roleLifepath_dict[dictKeys[i]]
		rolePath.get_node("branch_labels").add_child(rolePath_instance)
		
		match column:
			1:
				rolePath_instance.position = Vector2(-350, -70 + yOffset)
				column = 2
			2:
				rolePath_instance.position = Vector2(0, -70 + yOffset)
				yOffset += 80
				column = 1

func load_sheet():
		# With an If-statement, suddenly this works as intended. Previously, trying to set the label outside of the if-statement would return an error since apparently charRef wasn't set yet
	if(charRef):
		# Display stats
		statLabel_Int.text = str(charRef.intel)
		statLabel_Ref.text = str(charRef.reflex)
		statLabel_Dex.text = str(charRef.dex)
		statLabel_Tech.text = str(charRef.tech)
		statLabel_Cool.text = str(charRef.cool)
		statLabel_Will.text = str(charRef.will)
		statLabel_Luck.text = str(charRef.luck)
		statLabel_Move.text = str(charRef.move)
		statLabel_Body.text = str(charRef.body)
		statLabel_Emp.text = str(charRef.emp)
		
		# Initialize all skills, including custom skills
		initializeAllSkillGroups()
		generateCustomSkills()
		initializeCompoundedGroup()
		
		# Display info
		
		# This properly shows the character's name, presumably because at least at the moment, the name has been set in the Inspector.
		# The character's stats (that aren't just 0) also display properly for the same assumed reason.
		# I'm assuming that because the character's hit points first have to be calculated, the value doesn't exist early enough to be properly set
		# so they still remain at 0 by the time the displayHitPoints function gets called
		
		# Addendum: After creating a very basic method for creating a character, the stats and name now get fed in properly, so this is no longer an issue.
		infoLabel_CharName.text = charRef.charName
		infoLabel_CharRole.text = charRef.roleName
		displayHitPoints()
		displayHumanity()
		
		# Note: I believe there are a few conditions where the death save actually changes, so we may want to include it in a separate function too
		infoLabel_DeathSave.text = str(charRef.deathSave)
		
		infoLabel_SerWoundThreshold.text = str(charRef.seriousWoundThreshold)
		input_Cash.value = charRef.cash
		displayImpPoints()
		
		displayLifePath()
		displayRolePath()

func _on_imp_points_lt_input_value_changed(value):
	charRef.impPoints_lifetime = input_ImpPointsLT.value
	pass # Replace with function body.

func _on_cash_input_value_changed(value):
	charRef.cash = input_Cash.value
	pass # Replace with function body.

func _on_imp_points_input_value_changed(value):
	charRef.impPoints_cur = input_ImpPoints.value
	pass # Replace with function body.
