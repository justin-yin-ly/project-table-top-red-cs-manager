extends Node

class_name statAllo

@export var remPointsRef: Node
@export var btnDec: Node
@export var btnInc: Node
@export var statRef: Node
@export var startingLevel: int
@export var pointCost: int = 1
@export var pointMin: int = 0
@export var pointMax: int = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	btnDec.stat = statRef
	btnInc.stat = statRef
	statRef.text = str(startingLevel)
	btnDec.remPoints = remPointsRef
	btnInc.remPoints = remPointsRef
	
	btnDec.pointCost = pointCost
	btnInc.pointCost = pointCost
	btnDec.statMax = pointMax
	btnDec.statMin = pointMin
	btnInc.statMax = pointMax
	btnInc.statMin = pointMin
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
