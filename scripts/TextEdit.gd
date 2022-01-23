extends TextEdit


onready var font_resource = get('custom_fonts/font')


func _input(event):
	if event is InputEventWithModifiers:
		if Input.is_action_just_pressed("zoom_in"):
			font_resource.set_size(font_resource.get_size() + 1)
		elif Input.is_action_just_pressed("zoom_out"):
			font_resource.set_size(font_resource.get_size() - 1)
