extends Node

## Manages the hint coin collection notif, basically just hides it when player clicks


# Notify Global list of UI scenes that this is the hint coin notif
func _ready():
	GlobalUIScenes.HintCoinNotif = self


# If player clicks while the popup is visible, hide it
func _input(event):
	if not self.visible:
		return
		
	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			self.visible = false
