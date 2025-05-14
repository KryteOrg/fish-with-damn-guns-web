extends Node3D

var fish_left = 0
var fish_max = 0

var mod = null

func _ready():
	if name == "Armenia":
		fish_max = 55
	elif name == "Finland":
		fish_max = 101
	elif name == "UK":
		fish_max = 420
		
	fish_left = fish_max
	
	for I in range(0,fish_max):
		var c = get_node("AI").duplicate()
		add_child(c)
		c.position = Vector3(randi_range(-500,500),0.5,randi_range(-500,500))
		c.name = "AI" + str(I)
	
	get_node("AI").queue_free()
	
	set_meta("left",fish_max)
	
	await get_tree().create_timer(1).timeout
	
	if !OS.has_feature("web"):
		if mod != null:
			var success = ProjectSettings.load_resource_pack(mod)
			if success:
				print("Mod loaded successfully!")
				var loaded_script = load("res://mod.gd")

				if loaded_script:
					var node = Node.new() 
					node.set_script(loaded_script)
					add_child(node)
					print("Script successfully attached!")
				else:
					print("Failed to load script.")
		else:
			print("Failed to load mod.")
	else:
		print("ignoring mods for the web")
		
func _process(delta: float):
	fish_left = int(get_meta("left"))
	
	get_node("left").text = str(fish_left) + "/" + str(fish_max) + " fish left"
	
	if fish_left == 0:
		get_tree().change_scene_to_file("res://win.tscn")
