extends Control
class_name DiscussionPopup

## Activates the discussion popup at the player's mouse position
## with a correct profile image and dialogue text

## The profile image box
@export var profile_image: TextureRect

## The dialogue text box
@export var dialogue_text_box: RichTextLabel

## Static references to use with the static display_popup()
static var popup: Object
static var profile: TextureRect
static var text_box: RichTextLabel

## Set static references at ready
func _ready():
	DiscussionPopup.popup = self
	DiscussionPopup.profile = profile_image
	DiscussionPopup.text_box = dialogue_text_box


## If player clicks while the popup is visible, hide it
func _input(event):
	if not self.visible:
		return
		
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			self.visible = false


## Displays the discussion popup at the player's mouse position
static func display_popup(character: CharacterData, dialogue_text: String):
	profile.texture = character.default_profile
	text_box.text = dialogue_text
	popup.position = popup.get_global_mouse_position()
	popup.visible = true
