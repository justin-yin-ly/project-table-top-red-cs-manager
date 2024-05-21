extends Control

@export var scrollContainer: Node
var logArray = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func LogHeightCheck() -> bool:
	var height = 0
	for i in logArray.size():
		height += 100
	
	if(height > custom_minimum_size.y):
		return true
	else:
		return false

func ReOrganize():
	if(LogHeightCheck()):
		custom_minimum_size = Vector2(custom_minimum_size.x, custom_minimum_size.y + 100)
	
	var yValue = custom_minimum_size.y - 100
	for i in logArray.size():
		logArray[i].position = Vector2(10, yValue)
		print(logArray[i].position)
		yValue -= 100
	
	# Scroll to the very bottom of the scroll container
	await get_tree().create_timer(0.1).timeout
	scrollContainer.set_deferred("scroll_vertical", 999999)
