extends Node

## Subscribes the loading screen to the LoadingManager


## The loading screen's AnimationPlayer
@export var loading_anim: AnimationPlayer

# Subscribe to LoadingManager
func _ready():
	LoadingManager.loading_screen = self
	LoadingManager.loading_anim = loading_anim
