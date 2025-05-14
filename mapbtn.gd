extends Button

func _pressed() -> void:
	get_node("../../Pick").play()
	
	await get_tree().create_timer(0.5).timeout
	
	get_tree().change_scene_to_file("res://" + name + ".tscn")
