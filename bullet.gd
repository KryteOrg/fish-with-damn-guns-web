extends MeshInstance3D

var timer = 0

func _process(delta: float) -> void:
	translate(Vector3(0,0,delta * 50))
	
	global_transform.origin = position
	
	timer += delta
	
	if timer > 2:
		visible = false
		set_process(false)
