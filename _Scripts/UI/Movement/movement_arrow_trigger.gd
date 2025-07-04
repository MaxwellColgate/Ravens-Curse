extends Node

## Handles logic related to the movement arrows


# The path to the scene scene that the player should move too after pressing this arrow,
# storing the PackedScene causes some cyclical loading issues so we have to use the path instead
@export var target_scene_path: String

# Subscribe to the MovementManager's movement_state_changed signal
func _ready():
	MovementManager.movement_state_changed.connect(change_arrow_visibility)

# Show and hide this arrow when the player presses the move button
func change_arrow_visibility(is_visible: bool):
	self.visible = is_visible

# Move to target_scene after pressing this arrow
func _on_movement_arrow_trigger_pressed() -> void:
	MovementManager.walk_to_scene(target_scene_path)
