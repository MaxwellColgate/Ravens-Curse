extends Node

## Manages moving between location scenes


# Notifies subscribers that the player has started or stopped trying to move
signal movement_state_changed(activate_points: bool)

# The player's move button
var move_button: MoveButton

# The movement SFX player
var move_sfx: AudioStreamPlayer

# The parent that all new scenes should be placed under
var location_parent: Control

# The current scene the player is in
var current_scene

# Emits the movement_state_changed signal when the player hits the move button
func change_movement_state(is_moving: bool):
	movement_state_changed.emit(is_moving)

# Moves between location scenes when player hits a walk arrow
func walk_to_scene(scene_path: String):
	# Notify the move button that the player finished moving
	move_button.is_moving = false
	move_sfx.play()
	
	# Enable the loading screen
	LoadingManager.enable_loading_screen()
	
	# Delete old location scene
	current_scene.queue_free()
	
	# Spawn in new location scene
	var new_scene = load(scene_path).instantiate()
	location_parent.add_child(new_scene)
	
	# Set new_scene to the current scene
	current_scene = new_scene
	
	# Disable the loading screen
	LoadingManager.disable_loading_screen()
