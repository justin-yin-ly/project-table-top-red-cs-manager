extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setDesc(descIndex):
	match descIndex:
		0:
			self.text = "These skills must be at least level 2."
		1:
			self.text = "Awareness skills determine your awareness of your 
			environment and capability to notice things."
		2:
			self.text = "Body skills determine your proficiency in physical 
			tasks and measure your strength and endurance."
		3:
			self.text = "Control skills determine your proficiency in controlling 
			vehicles or riding animals."
		4:
			self.text = "Education skills measure your knowledge and training 
			based on formal education/schooling."
		5:
			self.text = "Fighting skills measure your ability to fight in 
			hand-to-hand and melee combat."
		6:
			self.text = "Performance skills involve acting, musicianship, 
			makeup, and other stage crafts."
		7:
			self.text = "Ranged Weapon skills measure your ability to use 
			ranged weapons such as bows and firearms."
		8:
			self.text = "Social skills determine your ability to fit into 
			social situations and convince others through social adeptness."
		9:
			self.text = "Technique skills involve trained vocational skills 
			and craftsmanship abilities."
		10:
			self.text = "These are other Education skills that allow you to
			specify what subject your character is trained in."
