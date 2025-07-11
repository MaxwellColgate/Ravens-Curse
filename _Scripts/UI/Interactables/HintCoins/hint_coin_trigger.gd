extends Node

## Gives the player a hint coin whenever on_hint_coin_found is called
## Expected to be attatched to a hint coin button in the world

## The hint coin sprite that appears when you click on the trigger
@export var coin: Control

## The hint coin trigger's audio stream
@export var coin_sfx: AudioStreamPlayer

## The hint coin's animation player
@export var coin_flip_anim: AnimationPlayer

## Has this coin already been collected?
var coin_collected = false


# Activates the coin flip animation at mouse pos
func hint_coin_found():
	if coin_collected == true:
		return
	coin_collected = true
	
	coin.global_position = get_viewport().get_mouse_position()
	coin.visible = true
	coin_flip_anim.play("UI/coin_flip")

# Provide the player with a new coin, usually called by the coin flip anim
func unlock_hint_coin():
	HintCoinNotification.display_notification()
