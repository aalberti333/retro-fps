extends Spatial

var body_to_move : KinematicBody = null

export var move_accel = 4
export var max_speed = 25
var drag = 0.0
export var jump_force = 30
export var gravity = 60

var pressed_jump = false
var move_vec : Vector3
var velocity : Vector3
var snap_vec : Vector3
# explained in video 4 at 17:10
# If set to true, it will move forward on the global plane, not the direction you're looking
# We'll want to set this to true for AI, but false for the player
export var ignore_rotation = false

signal movement_info

var frozen = false

func _ready():
	drag = float(move_accel) / max_speed
	
func init(_body_to_move: KinematicBody):
	body_to_move = _body_to_move

func jump():
	pressed_jump = true
	
func set_move_vec(_move_vec: Vector3):
	move_vec = _move_vec.normalized()

func _physics_process(delta):
	if frozen:
		return
	var cur_move_vec = move_vec
	if !ignore_rotation:
		cur_move_vec = cur_move_vec.rotated(Vector3.UP, body_to_move.rotation.y)
	velocity += move_accel * cur_move_vec - velocity * Vector3(drag, 0, drag) + gravity * Vector3.DOWN * delta
	velocity = body_to_move.move_and_slide_with_snap(velocity, snap_vec, Vector3.UP)
	
	# only updates when calling move and slide, so if we move down and we touch the floor, this will be true
	var grounded = body_to_move.is_on_floor()
	
	# always want to move down to keep this updated. If velocity.y is 0 instead,
	# this will be false next frame because we won't have moved down and touched the ground at all.
	# (grounded updates every physics frame, so this keeps it true so we can go through additional logic)
	if grounded:
		velocity.y = -0.01
	# only jump if we're on the ground
	if grounded and pressed_jump:
		velocity.y = jump_force
		# set this so we don't stick to the ground anymore
		snap_vec = Vector3.ZERO
	else:
		# set this so we WILL stick to the ground if we haven't just jumped
		snap_vec = Vector3.DOWN
	# This way pressed_jump is only true for one physics frame
	pressed_jump = false
	emit_signal("movement_info", velocity, grounded)
	
func freeze():
	frozen = true

func unfreeze():
	frozen = false
