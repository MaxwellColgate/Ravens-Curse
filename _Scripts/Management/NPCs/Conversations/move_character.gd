extends Control

## When notified, moves character to provided point

# How fast the character moves
@export var character_move_speed: float = 1

# How far through moving they are
var move_progress = 0.0

# The character's starting pos
var starting_pos: Vector2

# The character's target pos
var target_pos: Vector2

# Should character be moving?
var move: bool

# Give the player a new target 
func start_moving(target: Vector2):
	move = false
	move_progress = 0
	starting_pos = position
	target_pos = target
	move = true

func _process(delta: float) -> void:
	# If the character shouldn't be moving, don't
	if not move:
		return
		
	# If character has reached their destination, stop moving
	if move_progress >= 1:
		move = false
		return
	
	move_progress = 1 - (1 - move_progress) * (1 - move_progress)
	move_progress += delta * character_move_speed
	
	position = starting_pos.lerp(target_pos, move_progress)
