extends Node

## Notifies the global conversation_manager that this is the conversation scene

var conversation_manager

# Disable player input while the interact notification is playing
func disable_input():
	conversation_manager.visible = true

# Notifies the conversation manager to start a conversation
func start_conversation(dialogue: Array[ConversationData]):
	conversation_manager.begin_conversation(dialogue)
