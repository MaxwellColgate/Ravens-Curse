extends Control

## When notified, moves character to provided point

# How fast the character moves
@export var character_move_speed: float = 1

# How far through moving they are
@export var move_progress = 0.0

# The character's starting pos
var starting_pos: Vector2

# The character's target pos
var target_pos: Vector2

# Should character be moving?
var move: bool

# Is the character leaving the conversation?
var is_leaving: bool

# Move the character into the conversation
func enter_scene(target: Vector2):
	reset_movement()
	target_pos = target
	move = true

# Move the character away from the conversation
func exit_scene():
	is_leaving = true
	target_pos = starting_pos
	reset_movement()
	move = true

# Resets the character's movement so they can move again
func reset_movement():
	move = false
	move_progress = 0.0
	starting_pos = position

func _process(delta: float) -> void:
	# If the character shouldn't be moving, don't
	if not move:
		return
	
	# If character has reached their destination, stop moving
	# lerp doesn't quite reach 1, so stop at 0.9 instead
	if move_progress > 0.9:
		move = false
		# If character has finished leaving, destroy them
		if is_leaving:
			self.queue_free()
		return
	
	move_progress += delta * character_move_speed
	move_progress = sin((move_progress * PI) / 2)
	position = starting_pos.lerp(target_pos, move_progress)
