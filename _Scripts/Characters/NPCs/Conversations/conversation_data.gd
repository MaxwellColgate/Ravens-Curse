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


# Data assosciated with introducing a new character
@export_group("Introduction")

# Should this character enter on the left side of the screen?
@export var enter_left: bool = true


# Data assosciated with a character speaking
@export_group("Speaking")

# The text in this line of dialogue
@export var dialogue_text: String

# The possible poses a character can be in
enum available_posess
{
	IDLE,
	SHOCKED,
}

# The character's current pose
@export var character_pose: available_posess
