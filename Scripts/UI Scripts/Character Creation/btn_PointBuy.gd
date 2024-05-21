extends Node

# use a bool to control whether or not the button increase or decreases a given value
# true will be increase, false will be decrease
@export var incOrDec: bool

# reference to the specific label we're increasing and decreasing
@export var stat: Node

# reference to the remaining points label
@export var remPoints: Node
@export var pointCost: int = 1

# set custom minimum and maximum level
@export var statMax: int = 8
@export var statMin: int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func IncreaseOrDecrease():
	if(incOrDec && int(stat.text) < statMax && int(remPoints.text) > 0):
		stat.text = str(int(stat.text) + 1)
		remPoints.text = str(int(remPoints.text) - pointCost)
	elif(!incOrDec && int(stat.text) > statMin):
		stat.text = str(int(stat.text) - 1)
		remPoints.text = str(int(remPoints.text) + pointCost)


func _on_pressed():
	IncreaseOrDecrease()
	pass # Replace with function body.
