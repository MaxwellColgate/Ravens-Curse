extends Resource
class_name CharacterData

## Stores a specific character's data, such as their assets when used in dialogue
## or their profile pictures used in discussions

# The character's name
@export var name: String


@export_group("Assets")

@export_subgroup("Dialogue")

# The dialogue poses a character can have
@export var available_poses: Dictionary[String, Array] = {}

# Returns the correct character sprite for a requested line of dialogue
func get_character_pose(pose: String, is_talking: bool) -> Texture2D:
	var correct_pose: Texture2D
	
	# Finds the requested sprite's index in each sprite array,
	# at the moment just a 0 or 1 for if the character is talking or not
	var requested_sprite_index = 0
	if is_talking:
		requested_sprite_index = 1
	
	return available_poses.get(pose)[requested_sprite_index]


@export_subgroup("Discussion")

# The character's default profile sprite
@export var default_profile: Texture2D
