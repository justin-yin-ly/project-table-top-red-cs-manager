extends Node

var charRef: Node

@export var itemComp: Node
var itemDict = {}

@export var balanceNode: Node
var balance = 0

"""
The idea here is to keep our different dictionaries sanitized - 
I feel like if we edit the character's inventory dictionary directly at this stage, 
it may result in some frustrating bugs, so I'm first going to keep a separate dictionary of purchases 
that can be tweaked however we want, and then once purchases are finalized, 
set the inventoryDict to the purchaseDict
"""
var purchaseDict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	if(itemComp != null):
		itemDict = itemComp.item_dictionary
	
	if(balanceNode != null):
		balance = int(balanceNode.text)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Purchase(cost, itemName):
	if(balance >= cost):
		balance -= cost
		if(purchaseDict.keys().has(itemName)):
			purchaseDict[itemName] += 1 
		else:
			purchaseDict[itemName] = 1

func Refund(cost, itemName):
	if(purchaseDict.keys().has(itemName)):
		balance += cost
		purchaseDict[itemName] -= 1 
		if(purchaseDict[itemName] <= 0):
			purchaseDict.erase(itemName)

func FinalizePurchase():
	charRef.inventory_dict = purchaseDict.duplicate(true)
