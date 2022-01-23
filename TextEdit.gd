extends TextEdit


onready var font_resource = get('custom_fonts/font')


func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		font_resource.set_size(font_resource.get_size() + 1)
	if Input.is_action_just_pressed("zoom_out"):
		font_resource.set_size(font_resource.get_size() - 1)
