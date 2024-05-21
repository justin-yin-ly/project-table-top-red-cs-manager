extends Node

@export var charName: String
@export var hp: int
@export var atk: int
@export var def: int

var player = {
	"name": "unknown",
	"hp": 0,
	"atk": 0,
	"def": 0,
	"inventory": {
		"weapons": "sword",
		"armor": "plate"
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	player["name"] = charName
	player["hp"] = hp
	player["atk"] = atk
	player["def"] = def
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_game():
	# user:// is under %appdata%/Godot/app_userdata/[Project Name]
	# This is the only way to instantiate a DirAccess object, which is the only way to access the directory for things like making a new folder
	var directory = DirAccess.open("user://")
	if(!directory.dir_exists("user://ttr_characters")):
		directory.make_dir("user://ttr_characters")
	
	var file = FileAccess.open("user://ttr_characters/" + player["name"] + ".json", FileAccess.WRITE)
	var json_save = JSON.stringify(player)
	file.store_line(json_save)

func load_game():
	var save_file = FileAccess.open("user://ttr_characters/" + player["name"] + ".json", FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	json.parse(json_string)
	print(json.get_data())

func _on_button_pressed():
	save_game()
	pass # Replace with function body.


func _on_button_2_pressed():
	load_game()
	pass # Replace with function body.
