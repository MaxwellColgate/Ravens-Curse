@tool
extends Node

## Stores an NPCs dialogue that will be played when the player clicks on them


# The NPC's AnimationPlayer
@export var npc_anim: AnimationPlayer

# Is this dialogue going to lead to a puzzle?
@export var is_puzzle_conversation = false

# The dialogue that will play when talking with this character
@export var dialogue: Array[ConversationData]

# When NPC is clicked in, start conversation
func _on_pressed() -> void:
	# If this conversation will lead to a puzzle, play the puzzle notfier anim.
	# Otherwise, play the normal conversation notifier anim
	if is_puzzle_conversation:
		npc_anim.play("display_puzzle_icon")
	else:
		npc_anim.play("display_conversation_icon")

# After the notifier anim is done playing, start the conversation
func begin_dialogue():
	ConversationStarter.start_conversation(dialogue)
