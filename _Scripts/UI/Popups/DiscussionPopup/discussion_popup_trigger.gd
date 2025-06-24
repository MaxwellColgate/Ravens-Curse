extends Node

## Runs through the provided discussion whenever the player clicks this trigger

# The dialogue of this discussion
@export var dialogue: Array[DiscussionData]

# The current line of dialogue we are on
var current_dialogue_line = 0

# When pressed, iterate through the provided list of dialogue
func _on_discussion_popup_trigger_pressed() -> void:
	# Go back to first line when dialogue is over
	if current_dialogue_line == dialogue.size():
		current_dialogue_line = 0

	GlobalUIScenes.DiscussionPopup.display_popup(dialogue[current_dialogue_line].profile_texture, 
		dialogue[current_dialogue_line].dialogue_text)
	
	current_dialogue_line += 1
