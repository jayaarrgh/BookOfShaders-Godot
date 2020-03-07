extends Control

var shaders_path = "res://shaders"

#func get_dir_contents(rootPath: String) -> Array:
#	var data = {}
#	var dir = Directory.new()
#
#	if dir.open(rootPath) == OK:
#		dir.list_dir_begin(true, false)
#		_add_dir_contents(dir, data)
#	else:
#		push_error("An error occurred when trying to access the path.")
#
#	return data
#
#func _add_dir_contents(dir: Directory, data: Dictionary):
#	var file_name = dir.get_next()
#
#	while (file_name != ""):
#		var path = dir.get_current_dir() + "/" + file_name
#
#		if dir.current_is_dir():
##			print("Found directory: %s" % path)
#			var subDir = Directory.new()
#			subDir.open(path)
#			subDir.list_dir_begin(true, false)
#			data[path] = []
#			_add_dir_contents(subDir, data)
#		else:
##			print("Found file: %s" % path
#			var current_dir_str = dir.get_current_dir()
#			if data.has(current_dir_str):
#				data[current_dir_str].append(path)
#			else:
#				data[current_dir_str] = [path]
#
#		file_name = dir.get_next()
#
#	dir.list_dir_end()
#
#func get_directory_dictionary():
#	var data = get_dir_contents(shaders_path)
#	var dirs = {}
#	for dir in data[0]:
#		dirs[dir] = []
#		for f in data[1]:
#			if dir in f:
#				dirs[dir].append(f)
#	return dirs
#
#func build_UI_from_dict():
##	data = get_directory_dictionary()
#	pass

func _input(event):
	if event is InputEventMouseMotion:
		# send mouse movement to the shader - even if the shader doesn't have the param
		$ColorRect.material.set_shader_param('mouse_position', get_local_mouse_position())



func _ready():
	# show dialog immediately
	$FileDialog.popup()
#	var data = get_dir_contents(shaders_path)
	
#	# printing folder data.. not itself recursive...
#	for folder in data.keys():
#		yield(get_tree(),"idle_frame")
#		yield(get_tree(),"idle_frame")
#		print(folder, ": [")
#		for file in data[folder]:
#			yield(get_tree(),"idle_frame")
#			yield(get_tree(),"idle_frame")
#			print('	', file, ",")
#		print("	]")



func _on_FileDialog_file_selected(path):
	# NOTE: if FileDialog type is res, (rather than filesystem)
	# the file dialog appears, but is non functional...
	print('file selected: ', path)
	var shader = load(path)
	print(shader)
	$ColorRect.material.set_shader(shader)

func _on_SwitchShader_pressed():
	$FileDialog.popup()

# func _on_FileDialog_dir_selected(dir):
# 	# this is his on exports.. but not in editor...
# 	print('dir selected: ', dir)

# func _on_FileDialog_files_selected(paths):
# 	print('paths selected: ', paths)

# func _on_FileDialog_confirmed():
# 	print('confirmed')

# func _on_FileDialog_custom_action(action):
# 	print('custom action', action)
