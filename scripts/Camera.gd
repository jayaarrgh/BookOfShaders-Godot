extends Spatial


var mouse_sens = 0.2
var middle_clicked = false
var shift_pressed

onready var gimbleX = $GimbleX
onready var camera = $GimbleX/Camera

func _ready():
	pass # Replace with function body.

func _input(event):
	# TODO: other in editor mouse controls for camera
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MIDDLE:
			if event.pressed:
				middle_clicked = true
			elif !event.pressed: 
				middle_clicked = false
	if event is InputEventKey:
		if event.scancode == KEY_SHIFT:
			 shift_pressed = event.is_pressed()

	if event is InputEventMouseMotion:
		if middle_clicked:
			if shift_pressed:
				# TODO: limit camera movement to keep object in frame
				camera.translate_object_local(Vector3(event.relative.x*mouse_sens*0.05, event.relative.y*mouse_sens*0.05, 0.0))
			else:
				self.rotate_y(deg2rad(-event.relative.x*mouse_sens))
				gimbleX.rotate_x(deg2rad(-event.relative.y*mouse_sens))
			
