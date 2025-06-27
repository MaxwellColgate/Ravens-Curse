extends Node

## Stores an NPCs dialogue that will be played when the player clicks on them


# The characters that should appear when starting the conversation
@export var starting_characters = {CharacterData: ConversationData.available_posess}

# The dialogue that will play when talking with this character
@export var dialogue: Array[ConversationData]


# When NPC is clicked in, start conversation
func _on_pressed() -> void:
	ConversationStarter.start_conversation(dialogue)
