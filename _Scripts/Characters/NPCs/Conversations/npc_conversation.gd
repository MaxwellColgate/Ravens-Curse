extends Node

## Stores an NPCs dialogue that will be played when the player clicks on them

@export var dialogue: Array[ConversationData]


func _on_pressed() -> void:
	ConversationStarter.start_conversation(dialogue)
