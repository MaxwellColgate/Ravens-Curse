extends Node

## Notifies the global conversation_manager that this is the conversation scene

var conversation_manager


func start_conversation(dialogue: Array[ConversationData]):
	conversation_manager.begin_conversation(dialogue)
