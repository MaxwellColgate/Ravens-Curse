extends Resource
class_name DiscussionData

## Stores data related to a singular line of a larger discussion
##
## Other scripts can store an array of these and iterate through them
## to create a full discussion


## The profile texture displayed next to this line of dialogue
@export var profile_texture: CharacterData

## The actual line of dialogue
@export var dialogue_text: String
