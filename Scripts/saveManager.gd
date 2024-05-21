extends Node

@export var fileMessage: Node

@export var activeChar: Node
@export var activeSheet: Node
@export var loadedChar: String

@export var loadTab: Node
var mouseHovering = false
@export var loadContainer: Node

var instRef_creator = load("res://Prefabs/characterCreator.tscn")

# In case a character and sheet hasn't been made yet, we need to instantiate them when using the load function
var instRef_char = load("res://Prefabs/character.tscn")
var instRef_sheet = load("res://UI/characterSheet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_character(charRef):
	var directory = DirAccess.open("user://")
	if(!directory.dir_exists("user://ttr_characters")):
		directory.make_dir("user://ttr_characters")
	
	if(charRef == null):
		setTempMessage("Character doesn't exist yet - nothing to save!")
		return
	
	var file = FileAccess.open("user://ttr_characters/" + charRef.charName + ".json", FileAccess.WRITE)
	
	# We oughta include a warning for characters with the same name at some point.
	# As it stands, if you make a character and then make a second character with the same name, 
	# the first character's data will get overridden without warning when the player goes to save
	
	var json_save = JSON.stringify(charRef.export_save_dict())
	file.store_line(json_save)
	setTempMessage("Character successfully saved to user://ttr_characters/" + charRef.charName + ".json")

func load_character(charLoad):
	loadTab.visible = false # I'll be honest, this is just a quick and dirty way to get the save tab to close on clicking a character to load
	var save_file = FileAccess.open("user://ttr_characters/" + charLoad + ".json", FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	json.parse(json_string)
	var data_to_load = json.get_data()
	
	if(self.has_node("characterCreator")):
		get_node("characterCreator").free()
	
	if(activeChar == null):
		var charInstance = instRef_char.instantiate()
		activeChar = charInstance
		add_child(charInstance)
	
	if(activeSheet == null):
		var sheetInstance = instRef_sheet.instantiate()
		activeSheet = sheetInstance
		add_child(sheetInstance)
	
	activeChar.init_from_dict(data_to_load)
	activeSheet.charRef = activeChar
	activeSheet.load_sheet()
	setTempMessage("Loaded character " + charLoad + " successfully!")

func load_charList():
	# First we need to get rid of any existing buttons so we don't accidentally duplicate buttons
	var loadContChildren = loadContainer.get_children()
	for i in loadContChildren.size():
		loadContChildren[i].free()
	
	# Get the list of characters that exist in the saves folder
	var directory = DirAccess.open("user://ttr_characters")
	var fileList = directory.get_files()
	
	loadContainer.custom_minimum_size = Vector2(240, 40 * fileList.size())
	
	var yOffset = 0
	
	for i in fileList.size():
		var charToLoad = Button.new()
		charToLoad.text = fileList[i].trim_suffix(".json")
		charToLoad.custom_minimum_size = Vector2(200, 30)
		charToLoad.pressed.connect(load_character.bind(charToLoad.text))
		loadContainer.add_child(charToLoad)
		charToLoad.position = Vector2(20, 20 + yOffset)
		yOffset += 40
	# Generate a list of buttons in the load tab based on the fileList
	#	- Instantiate a button for every entry in the PackedStringArray
	#	- Set the text of this button to a corresponding entry in the array
	#	- Make sure their connection is properly hooked up (this is probably going to be the hardest part)

func setTempMessage(text):
	fileMessage.text = text
	await get_tree().create_timer(3.0).timeout
	fileMessage.text = ""

func _on_btn_save_pressed():
	save_character(activeChar)
	pass # Replace with function body.

func _on_btn_load_pressed():
	loadTab.visible = true
	load_charList()

func _on_btn_new_char_pressed():
	if(!self.has_node("characterCreator")):
		var creator = instRef_creator.instantiate()
		add_child(creator)
		creator.position = Vector2(0, -100)
	pass # Replace with function body.

func _input(event):
	if (event.is_action_pressed("left_click") && loadTab.visible == true && mouseHovering == false):
		await get_tree().create_timer(0.1).timeout
		loadTab.visible = false

func _on_scroll_container_mouse_entered():
	mouseHovering = true
	pass # Replace with function body.

func _on_scroll_container_mouse_exited():
	mouseHovering = false
	pass # Replace with function body.
