extends Object
class_name Util

# Thanks to https://www.davidepesce.com/2019/11/04/essential-guide-to-godot-filesystem-api/
static func copy_recursive(from, to):
	var directory = Directory.new()
	
	# create target directory, if nonexistent
	if directory.dir_exists(to): return
	else: directory.make_dir_recursive(to)
	
	# Open directory
	var error = directory.open(from)
	if error == OK:
		# List directory content
		directory.list_dir_begin(true)
		var file_name = directory.get_next()
		while file_name != "":
			if directory.current_is_dir():
				copy_recursive(from + "/" + file_name, to + "/" + file_name)
			else:
				directory.copy(from + "/" + file_name, to + "/" + file_name)
			file_name = directory.get_next()
	else:
		print("Error copying " + from + " to " + to)


# unused directory helpers


#func recursive_dirs_and_files_dict(dir, data):
#	var file_name = dir.get_next()
##
#	while (file_name != ""):
#		var path = dir.get_current_dir() + "/" + file_name
#		var _user_path = path.replace('res://', 'user://')
#		if dir.current_is_dir():
##			print("Found directory: %s" % path)
#			var subDir = Directory.new()
#			subDir.open(path)
#			subDir.list_dir_begin(true, false)
#			data[path] = []
#			recursive_dirs_and_files_dict(subDir, data)
#		else:
##			print("Found file: %s" % path)
#			var current_dir_str = dir.get_current_dir()
#			if data.has(current_dir_str):
#				data[current_dir_str].append(path)
#			else:
#				data[current_dir_str] = [path]
#		file_name = dir.get_next()
#	return data
#
#
#func get_dirs_and_files_dict():
#	var dir = Directory.new()
#	var data = {}
#	if dir.open(shaders_dir) == OK:
#		dir.list_dir_begin(true, false)
#		data = recursive_dirs_and_files_dict(dir, data)
#	return data
#
#func print_one_level_of_dirs_and_files(data):
#	for folder in data.keys():
#		yield(get_tree(),"idle_frame")
#		yield(get_tree(),"idle_frame")
#		print(folder, ": [")
#		for file in data[folder]:
#			yield(get_tree(),"idle_frame")
#			yield(get_tree(),"idle_frame")
#			print('	', file, ",")
#		print("	]")


# =================================================================


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
#	var data = get_dir_contents(shaders_dir)
#	var dirs = {}
#	for dir in data[0]:
#		dirs[dir] = []
#		for f in data[1]:
#			if dir in f:
#				dirs[dir].append(f)
#	return dirs
