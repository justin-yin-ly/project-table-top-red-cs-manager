extends Node

# Reference to message_roll scene - lets us generate a message to display in the roll history tab when we press the roll button
var instRef_message = load("res://UI/message_roll.tscn")

# character reference for grabbing stats for calculating rolls based on stat
@export var charRef: Node

# index for grabbing specific stat from charRef - use with charRef's getStatByIndex function
@export var statIndex: int

# index of which skillGroup to pull from charRef
@export var skillGroupIndex: int
# index of specific skill in skillGroup, for purpose of getting skill level
@export var skillIndex: int

@export var skillLevelTxt: Node
@export var skillLevelNum: int
@export var skillStat: Node
@export var skillTotal: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setStat():
	match statIndex:
		0:
			skillStat.text = "INT"
		1:
			skillStat.text = "REF"
		2:
			skillStat.text = "DEX"
		3:
			skillStat.text = "TECH"
		4:
			skillStat.text = "COOL"
		5:
			skillStat.text = "WILL"
		6:
			skillStat.text = "LUCK"
		7:
			skillStat.text = "MOVE"
		8:
			skillStat.text = "BODY"
		9:
			skillStat.text = "EMP"

func getLevelFromChar():
	var skillGroup = charRef.sklGrp_Group[skillGroupIndex]
	skillLevelNum = skillGroup[skillIndex]

func setLevelText():
	skillLevelTxt.text = "Lvl. " + str(skillLevelNum)

func calcSkillTotal():
	skillTotal.text = str(skillLevelNum + charRef.getStatByIndex(statIndex))

func initializeSkill():
	setStat()
	if(skillGroupIndex > -1):
		getLevelFromChar()
	setLevelText()
	calcSkillTotal()

func _on_button_pressed():
	# Instantiate a message
	var message_instance = instRef_message.instantiate()
	
	# Populate the necessary fields in the instanced message
	message_instance.skillName = self.text
	message_instance.skillLevel = skillLevelNum
	message_instance.stat = skillStat.text
	message_instance.statValue = charRef.getStatByIndex(statIndex)
	
	var dieRoll = charRef.genFuncs.roll_d(10)
	
	message_instance.dieResult = dieRoll
	
	var critMessage = ""
	
	if (dieRoll == 10):
		var critRes = charRef.genFuncs.roll_d(10)
		dieRoll += critRes
		critMessage = "[Critical success! :D]"
		message_instance.critState = 1
		message_instance.critResult = critRes
	elif (dieRoll == 1):
		var critRes = charRef.genFuncs.roll_d(10)
		dieRoll -= critRes
		critMessage = "[Critical failure! D:]"
		message_instance.critState = 2
		message_instance.critResult = -critRes
	
	dieRoll += int(skillTotal.text)
	var rollMessage = "Rolling " + self.text + " skill - rolled a " + str(dieRoll) + critMessage
	print(rollMessage)
	
	# Tell our instanced message to generate the actual text to display now that it has everything it needs
	message_instance.GenerateMessage()
	
	var roll_container = get_node("/root/Node2D/branch_rollHistory/ScrollContainer/container_rollHistory")
	roll_container.add_child(message_instance)
	roll_container.logArray.insert(0,message_instance)
	roll_container.ReOrganize()
	
	pass # Replace with function body.
