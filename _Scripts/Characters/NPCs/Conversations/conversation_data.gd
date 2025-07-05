@tool
extends Resource
class_name ConversationData

## Stores data related to a line of dialogue, multiple of these can
## be chained together to create a conversation


# The possible actions that can be taken with this line of dialogue
enum possible_actions
{
	SPEAK,
	INTRODUCE_CHARACTER,
}

# The action that will take place with this line of dialogue
@export var action: possible_actions

# The character involved with this action
@export var character: CharacterData


# The character's current pose
@export var character_pose = "default"

# Data assosciated with introducing a new character
@export_group("Introduction")

# Should this character enter on the left side of the screen?
@export var enter_left = true

# Should this character's sprite be flipped horizontally?
@export var flip_character = false

# Data assosciated with a character speaking
@export_group("Speaking")

# The text in this line of dialogue
@export var dialogue_text: String
