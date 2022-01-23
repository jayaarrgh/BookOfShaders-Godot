extends Control

const RES_SHADER_DIR : String = "res://shaders/3D"
const USER_SHADER_DIR : String = "user://shaders/3D"
# 3d template
const SHADER_TEMPLATE : String = "// NOTE: Shader automatically converted from Godot Engine 3.4.2.stable's SpatialMaterial.\n\nshader_type spatial;\nrender_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;\n//uniform vec4 albedo;\n//TODO: how to accept a texture in this editor\n//uniform sampler2D texture_albedo : hint_albedo;\nuniform float specular;\nuniform float metallic;\nuniform float roughness : hint_range(0,1);\nuniform float point_size : hint_range(0,128);\nuniform vec3 uv1_scale;\nuniform vec3 uv1_offset;\nuniform vec3 uv2_scale;\nuniform vec3 uv2_offset;\n\n\nvarying smooth vec3 our_color;\n//varying flat vec3 our_color;\n\nvoid vertex() {\n	our_color = VERTEX;\n	//our_color = COLOR.rgb;\n	UV=UV*uv1_scale.xy+uv1_offset.xy;\n}\n\n\nvoid fragment() {\n	//vec2 base_uv = UV;\n	//vec4 albedo_tex = texture(texture_albedo,base_uv);\n	\n	vec4 albedo = vec4(VERTEX.x, VERTEX.y, VERTEX.z, 1.0);	\n	//ALBEDO = albedo.rgb; // * albedo_tex.rgb;\n	ALBEDO = our_color.rgb;\n	//METALLIC = metallic;\n	//ROUGHNESS = roughness;\n	//SPECULAR = specular;\n}\n\n"

# update in 3d is a bit slower at Godot stutters when loading 3d shaders 
const UPDATE_SHADER : float = 1.0 # update shader every 1s
const SAVE_SHADER   : float = 4.0 # save every 4s

var update_delta = 0.0
var save_delta = 0.0
var current_shader_path : String
var main2d

onready var mesh_mat : Material = $"../MeshInstance".get_surface_material(0)
onready var textEdit := $TextEdit

func _ready():
	# res is not editable outside of editor - move res shaders to user directory
	Util.copy_recursive(RES_SHADER_DIR, USER_SHADER_DIR)
	# set the current shader path to the new or existing user path now
	current_shader_path = mesh_mat.shader.get_path().replace('res://', 'user://')
	mesh_mat.shader = load(current_shader_path)
	textEdit.text = mesh_mat.shader.code
	# pop up FileDialog on start, use user dir
	$FileDialog.current_dir = USER_SHADER_DIR
	$FileDialog.current_path = USER_SHADER_DIR
	$FileDialog.popup()
	# hide initially
	print('hit 3d _ready')
	set_process(false)
	get_parent().hide()
	self.hide()


func _input(event):
#	if event is InputEventMouseMotion:
		# send mouse movement to the shader - even if the shader doesn't have the param
#		mesh_mat.set_shader_param('mouse_position', get_local_mouse_position())
	pass


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
	mesh_mat.shader.set_code(textEdit.text)


func _save_shader():
	# TODO: ? allow user to choose whether autosave happens?
	var shader_to_save = mesh_mat.shader
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
	mesh_mat.shader.set_code(resource_shader.code)
	_save_shader()


func _on_NewShaderDialog_file_selected(path):
	# create new shader
	if not path.ends_with('.gdshader') or not path.ends_with('.shader'): return
	current_shader_path = path
	var new_shader = Shader.new()
	new_shader.code = SHADER_TEMPLATE
	textEdit.text = SHADER_TEMPLATE
	mesh_mat.set_shader(new_shader)
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
	mesh_mat.set_shader(shader)


func _on_2D_pressed():
	get_parent().hide()
	self.hide()
	self.set_process(false)
	main2d.show()
	main2d.set_process(true)
