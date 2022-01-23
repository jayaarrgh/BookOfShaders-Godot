extends Spatial


var mouse_sens = 0.2
var middle_clicked = false

onready var gimbleX = $GimbleX


func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MIDDLE:
			if event.pressed:
				middle_clicked = true
			elif !event.pressed: 
				middle_clicked = false
	if event is InputEventMouseMotion and middle_clicked:
		self.rotate_y(deg2rad(-event.relative.x*mouse_sens))
		gimbleX.rotate_x(deg2rad(-event.relative.y*mouse_sens))
