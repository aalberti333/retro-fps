extends KinematicBody

export var mouse_sens = 0.5

onready var camera = $Camera

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func _input(event):
	if event is InputEventMouseMotion:
		# Ensures y adjusts as x changes
		rotation_degrees.y -= mouse_sens * event.relative.x
		camera.rotation_degrees.x -= mouse_sens * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
