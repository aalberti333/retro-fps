extends KinematicBody

export var mouse_sens = 0.5

onready var camera = $Camera
onready var character_mover = $CharacterMover
onready var health_manager = $HealthManager

var dead = false

func _ready():
	# Layer: who you are, Mask: what you collide with (in editor)
	# makes mouse invisible, and keeps it at the center of the screen
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	character_mover.init(self)
	health_manager.init()
	# How to connect to signal via code instead of through GUI
	health_manager.connect("dead", self, "kill")

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
	if dead:
		return
	
	var move_vec = Vector3()
	if Input.is_action_pressed("move_forwards"):
		move_vec += Vector3.FORWARD
	if Input.is_action_pressed("move_backwards"):
		move_vec += Vector3.BACK
	if Input.is_action_pressed("move_left"):
		move_vec += Vector3.LEFT
	if Input.is_action_pressed("move_right"):
		move_vec += Vector3.RIGHT
	character_mover.set_move_vec(move_vec)
	if Input.is_action_just_pressed("jump"):
		character_mover.jump()

func _input(event):
	if event is InputEventMouseMotion:
		# Ensures y adjusts as x changes
		rotation_degrees.y -= mouse_sens * event.relative.x
		camera.rotation_degrees.x -= mouse_sens * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)

func hurt(damage, dir):
	health_manager.hurt(damage, dir)

func heal(amount):
	health_manager.heal(amount)

func kill():
	dead = true
	character_mover.freeze()
