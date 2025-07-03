extends Node

## Manages activating and deactivating the loading screen
## TO-DO: Make this actually work as a loading screen, 
## needs to pause whatever script you're running until the fade in is complete
## since I'm pretty sure it'll currently just freeze half way through


# The loading screen object
var loading_screen

# The loading screen animation player
var loading_anim: AnimationPlayer


func enable_loading_screen():
	loading_screen.visible = true
	loading_anim.play("loading_fade_in")
	
func disable_loading_screen():
	loading_anim.play("loading_fade_out")
