extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	"""
	To see the test runs of these functions, simply copy and paste them anywhere outside of this comment block
	print("sum is " + str(findSum([1,2,2]) as float))
	print("average is " + str(findAvg([1,2,2,1])))
	print("1.4 rounded is " + str(findRounded(1.4)))
	"""

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func findSum(nums)->int:
	var sum = 0
	for i in nums:
		sum += i
	return sum

# important note: remember what return type you have up here; GDScript will cast whatever you're returning into the declared return type
# gave myself an hour long headache because I couldn't figure out why my average kept returning as an integer when I suddenly remembered I set the return type to int
func findAverage(nums)->float:
	var sum = 0
	for i in nums:
		sum += i;

	var avg: float = float(sum) / nums.size() as float
	return avg

func findRounded(f)->int:
	# casting a float to int seems to always round it down
	var fInt = int(f)
	var decimal = f - float(fInt)
	
	# included so that we can properly round numbers
	if(decimal >= 0.5):
		return fInt + 1
	else:
		return fInt

func roll_d(sides)->int:
	var num = 1 + randi() % sides
	# print("Rolling d"+ str(sides) + ", rolled a " + str(num))
	return num

func multiRoll(rolls, sides)->int:
	var sum = 0
	for n in rolls:
		sum += roll_d(sides);
	return sum
