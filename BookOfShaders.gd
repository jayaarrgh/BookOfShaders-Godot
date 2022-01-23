extends Control


const RES_SHADER_DIR : String = "res://shaders"
const USER_SHADER_DIR : String = "user://shaders"
const SHADER_TEMPLATE : String = "shader_type canvas_item;\n\nvoid fragment(){\n\tCOLOR = vec4(vec3(0.0,0.5,0.3), 1.);\n}"
const UPDATE_SHADER : float = 0.2 # update shader every 200ms
const SAVE_SHADER   : float = 2.0 # save every 2 seconds

var update_delta = 0.0
var save_delta = 0.0
var current_shader_path : String

onready var main3d : Spatial = preload("res://Main3D.tscn").instance()
onready var colorRect := $ColorRect
onready var textEdit := $TextEdit


func _initialize_3d():
	# setup 3d scene
	get_tree().root.add_child(main3d)
	var main3dMain = main3d.get_node("Main")
	main3dMain.main2d = self
	main3dMain.visible = false
	main3dMain.set_process(false)
	main3d.visible = false


func _ready():
	# res is not editable outside of editor - move res shaders to user directory
	Util.copy_recursive(RES_SHADER_DIR, USER_SHADER_DIR)
	# set the current shader path to the new or existing user path now
	current_shader_path = colorRect.material.shader.get_path().replace('res://', 'user://')
	colorRect.material.shader = load(current_shader_path)
	textEdit.text = colorRect.material.shader.code
	# pop up FileDialog on start, use user dir
	$FileDialog.current_dir = USER_SHADER_DIR
	$FileDialog.current_path = USER_SHADER_DIR
	$FileDialog.popup()
	call_deferred('_initialize_3d')


func _input(event):
	if event is InputEventMouseMotion:
		# send mouse movement to the shader - even if the shader doesn't have the param
		colorRect.material.set_shader_param('mouse_position', get_local_mouse_position())


func _process(delta):
	update_delta += delta
	save_delta += delta
	if update_delta > UPDATE_SHADER:
		update_delta = float()
		_copy_editor_shader_code()
	if save_delta > SAVE_SHADER:
		save_delta = float()
		_save_shader()


func _copy_editor_shader_code():
	if textEdit.text == "": return
	colorRect.material.shader.set_code(textEdit.text)


func _save_shader():
	# TODO: ? allow user to choose whether autosave happens?
	var shader_to_save = colorRect.material.shader
	var _e = ResourceSaver.save(current_shader_path, shader_to_save)
	if _e != OK:
		print('something went wrong when trying to save shader')


## GUI CALLBACKS
func _on_NewShader_pressed():
	$NewShaderDialog.popup()


func _on_SwitchShader_pressed():
	$FileDialog.popup()


func _on_CodeToggle_toggled(_button_pressed):
	if textEdit.is_visible_in_tree(): textEdit.hide()
	else: textEdit.show()


func _on_Reset_pressed():
	# overwrite user data with res version
	var resource_version = current_shader_path.replace('user://', 'res://')
	var resource_shader = load(resource_version)
	if not resource_shader:
		print('Could not find original resource shader')
		return
	textEdit.text = resource_shader.code
	colorRect.material.shader.set_code(resource_shader.code)
	_save_shader()


func _on_NewShaderDialog_file_selected(path):
	# create new shader
	if not path.ends_with('.gdshader') or not path.ends_with('.shader'): return
	current_shader_path = path
	var new_shader = Shader.new()
	new_shader.code = SHADER_TEMPLATE
	textEdit.text = SHADER_TEMPLATE
	colorRect.material.set_shader(new_shader)
	_save_shader()


func _on_FileDialog_file_selected(path):
	# load the selected shader
	current_shader_path = path
	var shader = load(current_shader_path)
	if not shader:
		print('could not load resource')
		return
	if not shader is Shader:
		print('that wasnt a shader')
		return
	textEdit.text = shader.code
	colorRect.material.set_shader(shader)


func _on_3D_pressed():
	# hide this scene and turn off processing?
	main3d.visible = true
	var main3dMain = main3d.get_node('Main')
	main3dMain.visible = true
	main3dMain.set_process(true)
	self.hide()
	self.set_process(false)
