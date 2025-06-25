extends Resource
class_name CharacterData

## Stores a specific character's data, such as their assets when used in dialogue
## or their profile pictures used in discussions

# The character's name
@export var name: String


@export_group("Assets")


@export_subgroup("Dialogue")

#The character's default idle sprite
@export var default_idle: Texture2D

#The character's default talking sprite
@export var default_talking: Texture2D

#The character's shocked idle sprite
@export var shocked_idle: Texture2D

#The character's shocked talking sprite
@export var shocked_talking: Texture2D


@export_subgroup("Discussion")

# The character's default profile sprite
@export var default_profile: Texture2D
