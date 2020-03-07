extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dir
var shaders_path = "res://shaders"

func get_dir_contents(rootPath: String) -> Array:
	var files = []
	var directories = []
	var dir = Directory.new()

	if dir.open(rootPath) == OK:
		dir.list_dir_begin(true, false)
		_add_dir_contents(dir, files, directories)
	else:
		push_error("An error occurred when trying to access the path.")

	return [directories, files]

func _add_dir_contents(dir: Directory, files: Array, directories: Array):
	var file_name = dir.get_next()

	while (file_name != ""):
		var path = dir.get_current_dir() + "/" + file_name

		if dir.current_is_dir():
#			print("Found directory: %s" % path)
			var subDir = Directory.new()
			subDir.open(path)
			subDir.list_dir_begin(true, false)
			directories.append(path)
			_add_dir_contents(subDir, files, directories)
		else:
#			print("Found file: %s" % path)
			files.append(path)

		file_name = dir.get_next()

	dir.list_dir_end()

func _ready():
	get_directory_dictionary()
	$FileDialog.popup()

func get_directory_dictionary():
	var data = get_dir_contents(shaders_path)
	var dirs = {}
	for dir in data[0]:
		dirs[dir] = []
		for f in data[1]:
			if dir in f:
				dirs[dir].append(f)
	return dirs

func build_UI_from_dict():
	pass

func _on_FileDialog_file_selected(path):
	print(path)
	$ColorRect.material.shader = load(path)

func _on_SwitchShader_pressed():
	$FileDialog.popup()
