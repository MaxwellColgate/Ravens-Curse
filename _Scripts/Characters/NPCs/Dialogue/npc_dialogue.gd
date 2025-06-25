extends Node

## Stores an NPCs dialogue that will be played when the player clicks on them

@export var dialogue: Array[DialogueData]


func _on_pressed() -> void:
	print("Interacted with npc!")
