extends Node

## Plays a conversation between characters

# The dialogue text
@export var dialogue_text_box: RichTextLabel

# The name text
@export var name_text_box: RichTextLabel

# How fast dialogue is written to the screen
@export var letter_frequency: float = 0.02

# The current conversation
var conversation: Array[ConversationData]

# The current line of dialogue
var current_line  = 0

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
	
	# If player isn't using LMB or line isn't done playing, return
	# (line will finish early instead so writing_line will be false next click)
	if event.button_index != MOUSE_BUTTON_LEFT or writing_line:
		return

	# If we are at the last line of dialogue, end conversation
	if current_line == conversation.size() - 1:
		end_conversation()
		return
	
	current_line += 1
	play_line(conversation[current_line])


# begin a new conversation, conversation data is passed in from source (usually an NPC)
func begin_conversation(dialogue: Array[ConversationData]):
	self.visible = true
	conversation.append_array(dialogue)
	play_line(conversation[0])


# Runs all of the logic required to play a line of dialogue
func play_line(line: ConversationData):
	writing_line = true
	name_text_box.text = line.character.name
	dialogue_text_box.text = ""
	
	for letter: String in line.dialogue_text:
		# If player clicks, skip to the end of the line
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			dialogue_text_box.text = line.dialogue_text
			break
		
		dialogue_text_box.text += letter
		
		await get_tree().create_timer(letter_frequency).timeout
	
	writing_line = false

# Clear out all the data assosciated with this conversation and close the scene
func end_conversation():
	conversation.clear()
	current_line = 0
	self.visible = false
