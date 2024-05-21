extends Node

@export var execLP_labels: Array[Node]
@export var execLP_inputs: Array[Node]

@export var fixerLP_labels: Array[Node]
@export var fixerLP_inputs: Array[Node]
@export var fixerLP_labelsP: Array[Node]
@export var fixerLP_inputsP: Array[Node]

@export var lawmanLP_labels: Array[Node]
@export var lawmanLP_inputs: Array[Node]

@export var mediaLP_labels: Array[Node]
@export var mediaLP_inputs: Array[Node]

@export var medtechLP_labels: Array[Node]
@export var medtechLP_inputs: Array[Node]
@export var medtechLP_labelsP: Array[Node]
@export var medtechLP_inputsP: Array[Node]

@export var netrunnerLP_labels: Array[Node]
@export var netrunnerLP_inputs: Array[Node]
@export var netrunnerLP_labelsP: Array[Node]
@export var netrunnerLP_inputsP: Array[Node]

@export var nomadLP_inputs: Array[Node]
@export var nomadLP_labelsL: Array[Node]
@export var nomadLP_inputsL: Array[Node]
@export var nomadLP_labelsA: Array[Node]
@export var nomadLP_inputsA: Array[Node]
@export var nomadLP_labelsS: Array[Node]
@export var nomadLP_inputsS: Array[Node]

@export var rockerboyLP_labels: Array[Node]
@export var rockerboyLP_inputs: Array[Node]
@export var rockerboyLP_labelsP: Array[Node]
@export var rockerboyLP_inputsP: Array[Node]

@export var soloLP_labels: Array[Node]
@export var soloLP_inputs: Array[Node]

@export var techLP_labels: Array[Node]
@export var techLP_inputs: Array[Node]
@export var techLP_labelsP: Array[Node]
@export var techLP_inputsP: Array[Node]

@export var btn_create: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_selected(index):
	match index:
		0:
			btn_create.roleIndex = 0
			btn_create.rolePath_keys = execLP_labels
			btn_create.rolePath_values = execLP_inputs
		1:
			btn_create.roleIndex = 1
			print(fixerLP_inputs[1].selected)
			if(fixerLP_inputs[1].selected == 1):
				btn_create.rolePath_keys = fixerLP_labelsP
				btn_create.rolePath_values = fixerLP_inputsP
			else:
				btn_create.rolePath_keys = fixerLP_labels
				btn_create.rolePath_values = fixerLP_inputs
		2:
			btn_create.roleIndex = 2
			btn_create.rolePath_keys = lawmanLP_labels
			btn_create.rolePath_values = lawmanLP_inputs
		3:
			btn_create.roleIndex = 3
			btn_create.rolePath_keys = mediaLP_labels
			btn_create.rolePath_values = mediaLP_inputs
		4:
			btn_create.roleIndex = 4
			if(medtechLP_inputs[1].selected == 1):
				btn_create.rolePath_keys = medtechLP_labelsP
				btn_create.rolePath_values = medtechLP_inputsP
			else:
				btn_create.rolePath_keys = medtechLP_labels
				btn_create.rolePath_values = medtechLP_inputs
		5:
			btn_create.roleIndex = 5
			if(netrunnerLP_inputs[1].selected == 1):
				btn_create.rolePath_keys = netrunnerLP_labelsP
				btn_create.rolePath_values = netrunnerLP_inputsP
			else:
				btn_create.rolePath_keys = netrunnerLP_labels
				btn_create.rolePath_values = netrunnerLP_inputs
		6:
			btn_create.roleIndex = 6
			match nomadLP_inputs[1].selected:
				0:
					btn_create.rolePath_keys = nomadLP_labelsL
					btn_create.rolePath_values = nomadLP_inputsL
				1:
					btn_create.rolePath_keys = nomadLP_labelsA
					btn_create.rolePath_values = nomadLP_inputsA
				2:
					btn_create.rolePath_keys = nomadLP_labelsS
					btn_create.rolePath_values = nomadLP_inputsS
		7:
			btn_create.roleIndex = 7
			if(rockerboyLP_inputs[1].selected == 1):
				btn_create.rolePath_keys = rockerboyLP_labelsP
				btn_create.rolePath_values = rockerboyLP_inputsP
			else:
				btn_create.rolePath_keys = rockerboyLP_labels
				btn_create.rolePath_values = rockerboyLP_inputs
		8:
			btn_create.roleIndex = 8
			btn_create.rolePath_keys = soloLP_labels
			btn_create.rolePath_values = soloLP_inputs
		9:
			btn_create.roleIndex = 9
			if(techLP_inputs[1].selected == 1):
				btn_create.rolePath_keys = techLP_labelsP
				btn_create.rolePath_values = techLP_inputsP
			else:
				btn_create.rolePath_keys = techLP_labels
				btn_create.rolePath_values = techLP_inputs
	pass # Replace with function body.
