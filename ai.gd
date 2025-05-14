extends MeshInstance3D

var searching = false

var timer = 0

var timerb = 0

var timerbs = 0

var target = ""

func _process(delta: float):
	timer += delta
	
	timerb += delta
	
	timerbs += delta
	
	if searching == false:
		var who = randi_range(0,100)
		
		target = "Fish"
		
		if who >= 70:
			print("searching for ai to target")
			target = "AI" + str(randi_range(0,49))
			searching = true
		elif who < 70:
			print("targetting player")
			target = "Fish"
			searching = true
			
		timer = 0
	else:
		if timer > 10:
			searching = false
			timer = 0
			
	if get_node("../" + target) != null:
		if timerb > 2:
			var c = get_node("../Bullet").duplicate()
			get_node("..").add_child(c)
			c.position = position
			c.visible = true
			c.set_process(true)
			c.rotation = rotation
			c.name = "Bullet"
			c.translate(Vector3(-5,0,0))
			c.add_to_group("bullets")
			look_at(get_node("../" + target).position)
			timerb = 0
			timerbs = 0
				
		look_at(get_node("../" + target).position - Vector3(1,0,0))
		
		rotate_y(180)
				
		if global_transform.origin.distance_to(get_node("../" + target).global_transform.origin) > 5:
			translate(Vector3(0,0,delta * 50))
			
		position.y = 0.5
			
		global_transform.origin = position
		
		if position.z > 512 or position.z < -512 or position.x > 512 or position.x < -512:
			die()
			
		if timerbs > 0.3:
			var bullets = get_tree().get_nodes_in_group("bullets")
			for bullet in bullets:
				var distance = global_transform.origin.distance_to(bullet.global_transform.origin)
				if distance < 1:
					print("hit")
					die()
			
	else:
		searching = false
	
func die():
	print("fish died")
	get_node("..").set_meta("left",str(int(get_node("..").get_meta("left")) - 1))
	get_node("../Explode").play()
	queue_free()
