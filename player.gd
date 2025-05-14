extends MeshInstance3D

var vel = 0

var velr = 0

var dead = false

var timerbs = 0

func _process(delta: float) -> void:
	timerbs += delta
	
	if Input.is_action_pressed("forward"):
		if vel < 5:
			vel += delta
	elif Input.is_action_pressed("backward"):
		if vel > -5:
			vel -= delta
	else:
		if vel > 0:
			vel -= delta

	if Input.is_action_pressed("left"):
		velr += delta / 5
	elif Input.is_action_pressed("right"):
		velr -= delta / 5
	else:
		velr = 0
	
	if Input.is_action_just_pressed("menu"):
		dead = true
		die()
		
	if Input.is_action_just_pressed("shoot"):
		if timerbs > 0.5:
			var c = get_node("../Bullet").duplicate()
			get_node("..").add_child(c)
			c.position = position
			c.visible = true
			c.set_process(true)
			c.rotation = rotation
			c.name = "Bullet"
			c.add_to_group("bullets")
			c.translate(Vector3(-5,0,0))
			timerbs = 0
	
	translate(Vector3(0,0,vel))
	
	rotate_y(velr)
	
	if dead == false:
		if position.z > 512 or position.z < -512 or position.x > 512 or position.x < -512:
			die()
			
	if timerbs > 0.3:
		var bullets = get_tree().get_nodes_in_group("bullets")
		for bullet in bullets:
			var distance = global_transform.origin.distance_to(bullet.global_transform.origin)
			if distance < 1:
				print("hit")
				die()
			
	global_transform.origin = position
	
func die():
	print("dead")
	dead = true
	visible = false
	get_node("../Music").stop()
	get_node("../Explode").play()
	get_node("../Explosion").visible = true
	await get_tree().create_timer(0.5).timeout
		
	get_tree().change_scene_to_file("res://ui.tscn")
