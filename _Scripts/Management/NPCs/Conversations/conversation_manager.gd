extends Node

## Plays a conversation between characters


# The current conversation
var conversation: Array[ConversationData]

# The number of characters on the left side of the screen
var left_characters = 0

# The number of characters on the right side of the screen
var right_characters = 0

# The current line of dialogue
var current_line = 0


@export_group("Movement")

# How fast characters move when entering/exiting the scene
@export var character_move_speed: float = 0.1

@export_subgroup("Introduction")

# The parent node for new characters
@export var character_scene: Control

# The character prefab
@export var character_pref = load("res://_Scenes/Characters/Conversations/CharacterPref.tscn")

# The left and right position that characters aim for when entering screen
@export var character_marks: Array[Control]

# How far off screen characters spawn before moving on screen
@export var character_spawn_offest: float = 5


@export_group("Speaking")

# The dialogue text
@export var dialogue_text_box: RichTextLabel

# The name text
@export var name_text_box: RichTextLabel

# How fast dialogue is written to the screen
@export var letter_frequency: float = 0.02

# The character's currently on screen
var characters = {} #CharacterData: $"res://_Scenes/Characters/Conversations/CharacterPref.tscn"

# Is the current line being played?
var writing_line = false


# Notify conversation_starter that this is the manager so that anyone can start a convo
func _ready() -> void:
	ConversationStarter.conversation_manager = self

# Iterates through dialogue when the player clicks
func _input(event):
	# If conversation is not active, return
	if not self.visible:
		return
	
	# If player isn't clicking mouse, return
	if event is not InputEventMouseButton or not event.pressed:
		return
	
	# If player isn't using LMB, return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	# If the line is still being written, skip to the end of line and return
	if writing_line:
		writing_line = false
		return
	
	iterate_dialogue()



# begin a new conversation, conversation data is passed in from source (usually an NPC)
func begin_conversation(dialogue: Array[ConversationData]):
	self.visible = true
	
	conversation.append_array(dialogue)
	iterate_dialogue()

# Checks what should happen on this line of dialogue, then call that state
func iterate_dialogue():
	# If we are at the last line of dialogue, end conversation
	if current_line == conversation.size():
		end_conversation()
		return
	
	var line = conversation[current_line]
	current_line += 1
	
	match line.action:
		line.possible_actions.INTRODUCE_CHARACTER:
			introduce_character(line.character, line.enter_left)
		line.possible_actions.SPEAK:
			play_line(line)


# Spawns in a new character on declared side of screen before dragging them into view
func introduce_character(character: CharacterData, spawn_left: bool):
	# Spawn in new character
	var new_character = character_pref.instantiate()
	new_character.name = character.name
	character_scene.add_child(new_character)
	characters[character] = new_character
	
	# The spot this character should start
	var spawn_pos: Vector2
	spawn_pos.y = character_marks[0].position.y
	
	# The spot this character should move towards after spawning in
	var target_pos
	
	# Move character off screen and get target
	if spawn_left:
		spawn_pos.x -= character_spawn_offest
		target_pos = character_marks[0]
	else:
		spawn_pos.x = get_viewport().get_visible_rect().size.x + character_spawn_offest
		target_pos = character_marks[1]
	
	# Set character's position and texture
	new_character.position = spawn_pos
	new_character.get_node("CharacterTexture").texture = character.default_idle
	
	# Notify character to start moving towards their mark
	new_character.start_moving(target_pos.position)
	iterate_dialogue()


# Runs all of the logic required to play a line of dialogue
func play_line(line: ConversationData):
	writing_line = true
	name_text_box.text = line.character.name
	dialogue_text_box.text = ""
	
	if  characters.has(line.character):
		characters[line.character].get_node("CharacterTexture").texture = line.character.default_idle
	else:
		print("Tried to make character say something, but they aren't in the conversation!")
	
	
	for letter: String in line.dialogue_text:
		# If player ends writing_line early, skip to end of line
		if not writing_line:
			dialogue_text_box.text = line.dialogue_text
			break
		
		dialogue_text_box.text += letter
		
		await get_tree().create_timer(letter_frequency).timeout
	
	writing_line = false


# Clear out all the data assosciated with this conversation and close the scene
func end_conversation():
	conversation.clear()
	for character in characters:
		print(characters[character])
		#character_scene.remove_child(characters[character])
		characters[character].queue_free()
	current_line = 0
	self.visible = false
