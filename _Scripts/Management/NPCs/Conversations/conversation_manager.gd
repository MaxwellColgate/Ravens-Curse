extends Node

## Plays a conversation between characters


# The conversation animation player
@export var convo_transitions: AnimationPlayer


@export_group("Movement")

@export_subgroup("Introduction")

# The parent node for new characters
@export var character_scene: Control

# The character prefab
@export var character_pref = load("res://_Scenes/UI/Conversations/CharacterPref.tscn")

# The left and right position that characters aim for when entering screen
@export var character_marks: Array[Control]

# How far off screen characters spawn before moving on screen
@export var character_spawn_offest = 0.0

# The additional padding space between characters on each side of the screen
@export var character_padding = 250.0

# How many times larger then their normal height should characters be scaled too
@export var character_scale = 3


@export_group("Speaking")

# The dialogue text
@export var dialogue_text_box: RichTextLabel

# The name text
@export var name_text_box: RichTextLabel

# How fast dialogue is written to the screen
@export var letter_frequency: float = 0.02


# Is the current line being played?
var writing_line = false

# The current conversation
var conversation: Array[ConversationData]

# The character's currently on screen
var characters = {} #CharacterData: $"res://_Scenes/Characters/Conversations/CharacterPref.tscn"

# The characters that are currently on the left hand side of the screen
var left_characters: Array[Object]

# The characters that are currently on the right hand side of the screen
var right_characters: Array[Object]

# The current line of dialogue
var current_line = 0

# Is the conversation ready to begin? (Animations are done, etc.)
var conversation_ready = false


# Notify conversation_starter that this is the manager so that anyone can start a convo
func _ready() -> void:
	ConversationStarter.conversation_manager = self

# Iterates through dialogue when the player clicks
func _input(event):
	# If conversation is not active, return
	if not conversation_ready:
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
	convo_transitions.play("convo_fade_in")
	conversation.append_array(dialogue)
	conversation_ready = true
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
			introduce_character(line.character, line.character_pose, line.enter_left)
		line.possible_actions.SPEAK:
			play_line(line)


# Spawns in a new character on declared side of screen before dragging them into view
func introduce_character(character: CharacterData, pose: String, spawn_left: bool):
	# Spawn in new character
	var new_character = character_pref.instantiate()
	new_character.name = character.name
	character_scene.add_child(new_character)
	characters[character] = new_character
	
	var character_texture = new_character.get_node("CharacterTexture")
	character_texture.texture = character.get_character_pose(pose, false)
	
	# Scale character up based on their height so that they all look right
	character_texture.size.y = character_texture.texture.get_height() * character_scale
	character_texture.position.y = -character_texture.texture.get_height() * character_scale
	
	# The spot this character should start
	var spawn_pos = Vector2.ZERO
	spawn_pos.y = character_marks[0].position.y
	
	# The spot this character should move towards after spawning in
	var target_pos: Vector2
	target_pos.y = character_marks[0].position.y
	
	# Move character off screen and get target
	if spawn_left:
		spawn_pos.x -= character_spawn_offest
		
		# If there is already a character on the left side of the screen,
		# move this character next to that character instead of overlapping them
		if left_characters.size() > 0:
			# The latest character spawned on the left side of the screen
			var latest_character = left_characters.back()
			target_pos.x = latest_character.target_pos.x - character_padding
		else:
			target_pos.x = character_marks[0].position.x
		left_characters.append(new_character)
	else:
		spawn_pos.x = get_viewport().get_visible_rect().size.x + character_spawn_offest
		
		# If there is already a character on the right side of the screen,
		# move this character next to that character instead of overlapping them
		if right_characters.size() > 0:
			# The latest character spawned on the right side of the screen
			var latest_character = right_characters.back()
			target_pos.x = (latest_character.target_pos.x + latest_character.size.x
				+ character_padding)
		else:
			target_pos.x = character_marks[1].position.x - character_texture.size.x
		right_characters.append(new_character)
	new_character.position = spawn_pos
	
	# Notify character to start moving towards their mark
	new_character.enter_scene(target_pos)
	iterate_dialogue()


# Runs all of the logic required to play a line of dialogue
func play_line(line: ConversationData):
	writing_line = true
	name_text_box.text = line.character.name
	dialogue_text_box.text = ""
	
	# Cache character's sprite since it's used multiple times
	var character_texture = characters[line.character].get_node("CharacterTexture")
	if  characters.has(line.character):
		character_texture.texture = line.character.get_character_pose(line.character_pose, true)
	
	
	for letter: String in line.dialogue_text:
		# If player ends writing_line early, skip to end of line
		if not writing_line:
			dialogue_text_box.text = line.dialogue_text
			break
		
		dialogue_text_box.text += letter
		
		await get_tree().create_timer(letter_frequency).timeout
	
	character_texture.texture = line.character.get_character_pose(line.character_pose, false)
	writing_line = false


# Clear out all the data assosciated with this conversation and close the scene
func end_conversation():
	conversation_ready = false
	conversation.clear()
	left_characters.clear()
	right_characters.clear()
	current_line = 0
	
	for character in characters:
		characters[character].exit_scene()
	characters.clear()
	
	convo_transitions.play("convo_fade_out")
