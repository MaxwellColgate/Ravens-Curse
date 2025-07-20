extends Node
class_name HintCoinNotification

## Manages the hint coin collection notif, basically just hides it when player clicks

# Static reference to the actual notification object
static var notif

## Notify Global list of UI scenes that this is the hint coin notif
func _ready():
	notif = self


## If player clicks while the popup is visible, hide it
func _input(event):
	if not self.visible:
		return
		
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			self.visible = false

## Displays the 'You found a hint coin!' notification
static func display_notification():
	notif.visible = true
