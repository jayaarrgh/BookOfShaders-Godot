extends Spatial


const MOUSE_SENS = 0.2
const ZOOM_STEP  = 0.2
const MOVE_MOD   = 0.05

onready var gimbleX = $GimbleX
onready var camera = $GimbleX/Camera

var middle_clicked = false
var shift_pressed = false


# use unhandled input for zoom, so scrolling in menus does not effect 3d view	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		# need to be ignored or captured by UI first
		if event.button_index == BUTTON_WHEEL_UP:
			camera.translate_object_local(Vector3(0.0, 0.0, -ZOOM_STEP))
		if event.button_index == BUTTON_WHEEL_DOWN:
			camera.translate_object_local(Vector3(0.0, 0.0, ZOOM_STEP))


func _input(event):
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
				camera.translate_object_local(Vector3(-event.relative.x*MOUSE_SENS*MOVE_MOD, event.relative.y*MOUSE_SENS*MOVE_MOD, 0.0))
			else:
				gimbleX.rotate_x(deg2rad(-event.relative.y*MOUSE_SENS))
				self.rotate_y(deg2rad(-event.relative.x*MOUSE_SENS))
			
