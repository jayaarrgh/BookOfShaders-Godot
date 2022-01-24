extends Node
class_name ObjParse

# Obj parser made by Ezcha
# Created on 7/11/2018
# https://ezcha.net
# https://github.com/Ezcha/gd-obj
# MIT License
# https://github.com/Ezcha/gd-obj/blob/master/LICENSE


#static func parse_obj(obj_path, mtl_path):
# altered sig so we just import mesh for now
static func parse_obj(obj_path):
	var file = File.new()
	file.open(obj_path, File.READ)
	var obj = file.get_as_text()
#	var mats = _parse_mtl_file(mtl_path)

	# Setup
	var mesh = Mesh.new()
	var vertices = PoolVector3Array()
	var normals = PoolVector3Array()
	var uvs = PoolVector2Array()
	var faces = {}
	var fans = []

	var firstSurface = true
	var mat_name = null

	# Parse
	var lines = obj.split("\n", false)
	for line in lines:
		var parts = line.split(" ", false)
		match parts[0]:
			"#":
				# Comment
				#print("Comment: "+line)
				pass
			"v":
				# Vertice
				var n_v = Vector3(float(parts[1]), float(parts[2]), float(parts[3]))
				vertices.append(n_v)
			"vn":
				# Normal
				var n_vn = Vector3(float(parts[1]), float(parts[2]), float(parts[3]))
				normals.append(n_vn)
			"vt":
				# UV
				var n_uv = Vector2(float(parts[1]), 1 - float(parts[2]))
				uvs.append(n_uv)
			"usemtl":
#				# Material group
				mat_name = parts[1]
				if(not faces.has(mat_name)):
					faces[mat_name] = []
			"f":
				# Face
				if (parts.size() == 4):
					# Tri
					var face = {"v":[], "vt":[], "vn":[]}
					for map in parts:
						var vertices_index = map.split("/")
						if (str(vertices_index[0]) != "f"):
							face["v"].append(int(vertices_index[0])-1)
							face["vt"].append(int(vertices_index[1])-1)
							face["vn"].append(int(vertices_index[2])-1)
					faces[mat_name].append(face)
				elif (parts.size() > 4):
					# Triangulate
					var points = []
					for map in parts:
						var vertices_index = map.split("/")
						if (str(vertices_index[0]) != "f"):
							var point = []
							point.append(int(vertices_index[0])-1)
							point.append(int(vertices_index[1])-1)
							point.append(int(vertices_index[2])-1)
							points.append(point)
					for i in (points.size()):
						if (i != 0):
							var face = {"v":[], "vt":[], "vn":[]}
							var point0 = points[0]
							var point1 = points[i]
							var point2 = points[i-1]
							face["v"].append(point0[0])
							face["v"].append(point2[0])
							face["v"].append(point1[0])
							face["vt"].append(point0[1])
							face["vt"].append(point2[1])
							face["vt"].append(point1[1])
							face["vn"].append(point0[2])
							face["vn"].append(point2[2])
							face["vn"].append(point1[2])
#							faces[mat_name].append(face)

	# Make tri
	for matgroup in faces.keys():
		print("Creating surface for matgroup " + matgroup + " with " + str(faces[matgroup].size()) + " faces")

		# Mesh Assembler
		var st = SurfaceTool.new()
		st.begin(Mesh.PRIMITIVE_TRIANGLES)

#		st.set_material(mats[matgroup])
		for face in faces[matgroup]:
			if (face["v"].size() == 3):
				# Vertices
				var fan_v = PoolVector3Array()
				fan_v.append(vertices[face["v"][0]])
				fan_v.append(vertices[face["v"][2]])
				fan_v.append(vertices[face["v"][1]])

				# Normals
				var fan_vn = PoolVector3Array()
				fan_vn.append(normals[face["vn"][0]])
				fan_vn.append(normals[face["vn"][2]])
				fan_vn.append(normals[face["vn"][1]])

#				# Textures
				var fan_vt = PoolVector2Array()
				fan_vt.append(uvs[face["vt"][0]])
				fan_vt.append(uvs[face["vt"][2]])
				fan_vt.append(uvs[face["vt"][1]])

				st.add_triangle_fan(fan_v, fan_vt, PoolColorArray(), PoolVector2Array(), fan_vn, [])
		mesh = st.commit(mesh)

	# Finish
	return mesh


# Returns an array of materials from a MTL file
static func _parse_mtl_file(path):
	print("Parsing mtl file " + path)
	var file = File.new()
	file.open(path, File.READ)
	var obj = file.get_as_text()

	var mats = {}
	var currentMat = null

	var lines = obj.split("\n", false)
	for line in lines:
		var parts = line.split(" ", false)
		match parts[0]:
			"#":
				# Comment
				#print("Comment: "+line)
				pass
			"newmtl":
				# Create a new material
				print("Adding new material " + parts[1])
				currentMat = SpatialMaterial.new()
				mats[parts[1]] = currentMat
			"Ka":
				# Ambient color
				#currentMat.albedo_color = Color(float(parts[1]), float(parts[2]), float(parts[3]))
				pass
			"Kd":
				# Diffuse color
				currentMat.albedo_color = Color(float(parts[1]), float(parts[2]), float(parts[3]))
				print("Setting material color " + str(currentMat.albedo_color))
				pass
			"map_Kd":
				# Texture file
				currentMat.albedo_texture = _get_texture(path, parts[1])
			"map_Ks":
				# Texture file
				currentMat.albedo_texture = _get_texture(path, parts[1])
			"map_Ka":
				# Texture file
				currentMat.albedo_texture = _get_texture(path, parts[1])

	return mats


static func _get_texture(mtl_filepath, tex_filename):
	print("    Debug: Mapping texture file " + tex_filename)
	var texfilepath = mtl_filepath.get_base_dir() + "/" + tex_filename
	var filetype = texfilepath.get_extension()
	print("    Debug: texture file path: " + texfilepath + " of type " + filetype)
	var tex = ImageTexture.new()
	var img = Image.new()
	img.load(texfilepath)
	tex.create_from_image(img)
	print("    Debug: texture is " + str(tex))
	return tex
