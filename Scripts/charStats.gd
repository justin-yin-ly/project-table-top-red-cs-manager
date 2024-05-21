extends Node

# Something worth noting: You don't need to export a variable to use it in other scripts. 
# Exporting is only if you want to be able to see/set it in the inspector
var charName: String
var roleName: String
var intel: int
var reflex: int
var dex: int
var tech: int
var cool: int
var will: int
var move: int
var body: int

# Max luck - luck_cur refills to this amount between every session
var luck: int
var luck_cur: int

# Max empathy, which is determined at character creation. 
var emp: int
# Current empathy, which is determined by the tens place of humanity_cur (i.e. 35 humanity_cur means 3 emp_cur)
# This is the value we ought to return in getStatByIndex
var emp_cur: int

var hitPoints_cur: int
var hitPoints_max: int
var seriousWoundThreshold: int
var deathSave: int

# Humanity Max is reduced every time a character installs new cyberware - remember this when implement cyberware later
var humanity_max: int
var humanity_cur: int

var impPoints_lifetime: int
var impPoints_cur: int

var cash: int

# Array of skill groups - used by skill to determine which skill level to use in its calculations
var sklGrp_Group = []

# Skill groups - determined by assigning values into separate arrays, with each array corresponding to a skill group
var sklGrp_awareness: Array[int]
var sklGrp_body: Array[int]
var sklGrp_control: Array[int]
var sklGrp_education: Array[int]
var sklGrp_fighting: Array[int]
var sklGrp_performance: Array[int]
var sklGrp_rangedWep: Array[int]
var sklGrp_social: Array[int]
var sklGrp_technique: Array[int]

var subGrp_language = []
var subGrp_localExp = []
var subGrp_science = []
var subGrp_playInstr = []

# Lifepath data
var lifepath_data = []
var roleLifepath_dict = {}

# Equipment dictionaries
var inventoryDict = {} # General inventory that keeps tabs on the count of everything that a character owns
var equipmentDict = { # Equipment inventory that manages what the player currently has equipped in regards to combat equipment
	"Head": "None",
	"Body": "None",
	"Hands": "None",
}
var fashionDict = { # An entirely different dictionary for handling the slots for fashion since I've just realized that's its own thing
	"Hat": "None",
	"Contact Lenses": "None",
	"Eyewear": "None",
	"Jewelry": "None",
	"Jacket": "None",
	"Top": "None",
	"Bottoms": "None",
	"Footwear": "None"
}
var cyberwareDict = {  # Cyberware slots - overall structure is actually quite a bit different from standard equipment
	"Fashionware": {"slots": 7},
	"Inter-Cyberware": {"slots": 7},
	"Exter-Cyberware": {"slots": 7}
} # How this works is that when you go to install cyberware, whatever script I have handling that will check to see if
  # the character has the prerequisite components, like how you need a neural link for neural cyberware or a cyber eye
  # for cyber optics. How it does that is by checking the cyberwareDict to see if it has an entry for that prerequisite
  # implant. If not, no dice. When a player does decide to get what they need, simply add it as a new key to the dictionary.
  # Any actually installed cyberware is kept track of in a sub-dictionary.

# To hold a reference to my genericFunctions script
@export var genFuncs: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	# calcHP()
	# V Uncomment this line if you want proof that the HP is being set correctly
	# print(hitPoints_max)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func calcHP():
	# This works as intended, though the value doesn't update in the Inspector for some reason
	hitPoints_max = 10 + (5 * genFuncs.findRounded(genFuncs.findAverage([body, will])))

func calcEMP():
	# Get the 10s place of humanity_cur, that determines what emp_cur is
	var humanSingles = humanity_cur & 10
	var humanTens = humanity_cur - humanSingles
	emp_cur = humanTens / 10

func initializeStats(passedName, passedRoleIndex, passedInt, passedRef, passedDex, passedTech, passedCool, passedWill, passedLuck, passedMove, passedBody, passedEmp):
	charName = passedName
	setRole(passedRoleIndex)
	intel = passedInt
	reflex = passedRef
	dex = passedDex
	tech = passedTech
	cool = passedCool
	will = passedWill
	luck = passedLuck
	move = passedMove
	body = passedBody
	emp = passedEmp
	
	calcHP()
	hitPoints_cur = hitPoints_max
	seriousWoundThreshold = genFuncs.findRounded(hitPoints_max as float / 2.0)
	luck_cur = luck
	emp_cur = emp
	cash = 0
	deathSave = body
	humanity_max = 10 * emp
	humanity_cur = humanity_max
	impPoints_lifetime = 0
	impPoints_cur = 0

func setRole(index):
	match index:
		0:
			roleName = "Exec"
		1:
			roleName = "Fixer"
		2:
			roleName = "Lawman"
		3:
			roleName = "Media"
		4:
			roleName = "Medtech"
		5:
			roleName = "Netrunner"
		6:
			roleName = "Nomad"
		7:
			roleName = "Rockerboy"
		8:
			roleName = "Solo"
		9:
			roleName = "Tech"

func getStatByIndex(index)->int:
	match index:
		0:
			return intel
		1:
			return reflex
		2:
			return dex
		3:
			return tech
		4:
			return cool
		5:
			return will
		6:
			return luck
		7:
			return move
		8:
			return body
		9:
			return emp_cur
		_:
			return -99

func getStatByName(input)->int:
	match input:
		"INT":
			return intel
		"REF":
			return reflex
		"DEX":
			return dex
		"TECH":
			return tech
		"COOL":
			return cool
		"WILL":
			return will
		"LUCK":
			return luck
		"MOVE":
			return move
		"BODY":
			return body
		"EMP":
			return emp_cur
		_:
			return -99

func initializeArrayArray():
	sklGrp_Group.append(sklGrp_awareness)
	sklGrp_Group.append(sklGrp_body)
	sklGrp_Group.append(sklGrp_control)
	sklGrp_Group.append(sklGrp_education)
	sklGrp_Group.append(sklGrp_fighting)
	sklGrp_Group.append(sklGrp_performance)
	sklGrp_Group.append(sklGrp_rangedWep)
	sklGrp_Group.append(sklGrp_social)
	sklGrp_Group.append(sklGrp_technique)

func export_save_dict():
	var save_dict = {
		"charName" : charName,
		"roleName" : roleName,
		"intel" : intel,
		"reflex" : reflex,
		"dex" : dex,
		"tech" : tech,
		"cool" : cool,
		"will" : will,
		"move" : move,
		"body" : body,
		"luck" : luck,
		"luck_cur": luck_cur,
		"emp" : emp,
		"emp_cur" : emp_cur,
		"hitPoints_cur" : hitPoints_cur,
		"hitPoints_max" : hitPoints_max,
		"humanity_cur" : humanity_cur,
		"humanity_max" : humanity_max,
		"impPoints_cur" : impPoints_cur,
		"impPoints_lifetime" : impPoints_lifetime,
		"cash" : cash,
		"sklGrp_Group": sklGrp_Group,
		"subGrp_language": subGrp_language,
		"subGrp_localExp": subGrp_localExp,
		"subGrp_science": subGrp_science,
		"subGrp_playInstr": subGrp_playInstr,
		"lifepath_data": lifepath_data,
		"roleLifepath_dict": roleLifepath_dict,
		"inventoryDict": inventoryDict,
		"equipmentDict": equipmentDict,
		"fashionDict": fashionDict,
		"cyberwareDict": cyberwareDict,
	}
	
	return save_dict

func load_from_dict(dict):
	charName = dict["charName"]
	roleName = dict["roleName"]
	intel = dict["intel"]
	reflex = dict["reflex"]
	dex = dict["dex"]
	tech = dict["tech"]
	cool = dict["cool"]
	will = dict["will"]
	move = dict["move"]
	body = dict["body"]
	luck = dict["luck"]
	luck_cur = dict["luck_cur"]
	emp = dict["emp"]
	emp_cur = dict["emp_cur"]
	hitPoints_cur = dict["hitPoints_cur"]
	hitPoints_max = dict["hitPoints_max"]
	humanity_cur = dict["humanity_cur"]
	humanity_max = dict["humanity_max"]
	impPoints_cur = dict["impPoints_cur"]
	impPoints_lifetime = dict["impPoints_lifetime"]
	cash = dict["cash"]
	sklGrp_Group = dict["sklGrp_Group"]
	subGrp_language = dict["subGrp_language"]
	subGrp_localExp = dict["subGrp_localExp"]
	subGrp_science = dict["subGrp_science"]
	subGrp_playInstr = dict["subGrp_playInstr"]
	lifepath_data = dict["lifepath_data"]
	roleLifepath_dict = dict["roleLifepath_dict"]
	inventoryDict = dict["inventoryDict"]
	equipmentDict = dict["equipmentDict"]
	fashionDict = dict["fashionDict"]
	cyberwareDict = dict["cyberwareDict"]

func init_from_dict(dict):
	load_from_dict(dict)
	deathSave = body
	seriousWoundThreshold = genFuncs.findRounded(hitPoints_max as float / 2.0)
