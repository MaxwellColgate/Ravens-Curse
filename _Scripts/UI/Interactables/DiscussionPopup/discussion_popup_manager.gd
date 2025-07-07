extends Control

## Activates the discussion popup at the player's mouse position
## with a correct profile image and dialogue text

## The profile image box
@export var profile_image: TextureRect

## The dialogue text box
@export var dialogue_text_box: RichTextLabel


# Notify Global list of UI scenes that this is the discussion popup
func _ready():
	GlobalUIScenes.DiscussionPopup = self


# If player clicks while the popup is visible, hide it
func _input(event):
	if not self.visible:
		return
		
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			self.visible = false


# Set proper profile picture and dialogue text, then show the dialogue box
func display_popup(character: CharacterData, dialogue_text: String):
	profile_image.texture = character.default_profile
	dialogue_text_box.text = dialogue_text
	self.position = get_viewport().get_mouse_position()
	self.visible = true
