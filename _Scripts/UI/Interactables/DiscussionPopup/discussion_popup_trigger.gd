extends Node

## Runs through the provided discussion whenever the player clicks this trigger

## The dialogue of this discussion
@export var dialogue: Array[DiscussionData]

## The current line of dialogue we are on
var current_dialogue_line = 0


# When pressed, iterate through the provided list of dialogue
func _on_discussion_popup_trigger_pressed() -> void:
	# Don't play a line when discussion is over, 
	# but reset convo for if the player clicks again
	if current_dialogue_line == dialogue.size():
		current_dialogue_line = 0
		return

	GlobalUIScenes.DiscussionPopup.display_popup(dialogue[current_dialogue_line].profile_texture, 
		dialogue[current_dialogue_line].dialogue_text)
	
	current_dialogue_line += 1
