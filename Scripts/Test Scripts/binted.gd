extends Bogos

var dictName = "testKey"
var dictValue = "testValue"

# Called when the node enters the scene tree for the first time.
func _ready():
	var test_dict = {
		dictName: dictValue
	}
	print(test_dict)
	eeby()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func eeby():
	super()
	print(" binted?")
