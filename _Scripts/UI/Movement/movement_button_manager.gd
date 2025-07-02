extends Node
class_name MoveButton

## Manges the logic related to the player's movement button


# The node that all location scenes are parented too
@export var location_scene_parent: Control

# Is the player currently trying to move?
var is_moving = false

# Provide movement manager with starting scene on game start, will probably be
# replaced when we add saving and loading from a main menu
func _ready():
	MovementManager.move_button = self
	MovementManager.location_parent = location_scene_parent
	MovementManager.current_scene = location_scene_parent.get_child(0)

# Start or stop moving when player presses on the movement button
func _on_movement_button_pressed() -> void:
	is_moving = !is_moving
	MovementManager.change_movement_state(is_moving)
