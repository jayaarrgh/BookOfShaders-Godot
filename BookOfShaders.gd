extends Control

var res_shaders_dir = "res://shaders"
var user_shaders_dir = "user://shaders"
var current_shader_path : String

const UPDATE_SHADER : float = 0.2 # update shader every 200ms
const SAVE_SHADER   : float = 2.0 # save every 2 seconds

var d = 0.0
var d2 = 0.0

func _ready():
	# res is not editable outside of editor - move res shaders to user directory
	Util.copy_recursive(res_shaders_dir, user_shaders_dir)
	# set the current shader path to the new or existing user path now
	current_shader_path = $ColorRect.material.shader.get_path().replace('res://', 'user://')
	$ColorRect.material.shader = load(current_shader_path)
	$TextEdit.text = $ColorRect.material.shader.code
	# pop up FileDialog on start, use user dir
	$FileDialog.current_dir = user_shaders_dir
	$FileDialog.current_path = user_shaders_dir
	$FileDialog.popup()

func _input(event):
	if event is InputEventMouseMotion:
		# send mouse movement to the shader - even if the shader doesn't have the param
		$ColorRect.material.set_shader_param('mouse_position', get_local_mouse_position())

func _process(delta):
	d += delta
	d2 += delta
	if d > UPDATE_SHADER:
		d = float()
		_copy_editor_shader_code()
	if d2 > SAVE_SHADER:
		d2 = float()
		_save_shader()

func _copy_editor_shader_code():
	if $TextEdit.text == "": return
	$ColorRect.material.shader.set_code($TextEdit.text)

func _save_shader():
	# TODO: ? allow user to choose whether autosave happens?
	var shader_to_save = $ColorRect.material.shader
	var _e = ResourceSaver.save(current_shader_path, shader_to_save)
	if _e != OK:
		print('something went wrong when trying to save shader')

## GUI CALLBACKS

func _on_SwitchShader_pressed():
	$FileDialog.popup()

func _on_FileDialog_file_selected(path):
	_load_shader(path)

func _on_CodeToggle_toggled(_button_pressed):
	if $TextEdit.is_visible_in_tree(): $TextEdit.hide()
	else: $TextEdit.show()

func _on_Reset_pressed():
	_reset_to_default_shader()

func _load_shader(path):
	current_shader_path = path
	var shader = load(current_shader_path)
	if not shader:
		print('could not load resource')
		return
	if not shader is Shader:
		print('that wasnt a shader')
		return
	$ColorRect.material.set_shader(shader)
	$TextEdit.text = shader.code

func _reset_to_default_shader():
	var resource_version = current_shader_path.replace('user://', 'res://')
	var resource_shader = load(resource_version)
	if not resource_shader:
		print('Could not find original resource shader')
		return
	$ColorRect.material.shader.set_code(resource_shader.code)
	$TextEdit.text = resource_shader.code
	_save_shader()
