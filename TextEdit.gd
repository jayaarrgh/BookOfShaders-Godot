extends TextEdit



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		var font_resource = get("custom_fonts/font")
		font_resource.set_size(font_resource.get_size() + 1)
	if Input.is_action_just_pressed("zoom_out"):
		var font_resource = get("custom_fonts/font")
		font_resource.set_size(font_resource.get_size() - 1)
