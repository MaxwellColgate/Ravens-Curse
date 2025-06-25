extends Resource
class_name DialogueData

## Stores data related to a line of dialogue, multiple of these can
## be chained together to create a conversation

# The text in this line of dialogue
@export var dialogue_text: String

# The character speaking
@export var character: CharacterData
