extends Node

## Gives the player a hint coin whenever on_hint_coin_found is called
## Expected to be attatched to a hint coin button in the world


func hint_coin_found():
	print("Found hint coin!")
