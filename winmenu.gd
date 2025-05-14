extends Button

func _on_pressed() -> void:
	get_node("../Win").stop()
	get_node("../Explode").play()
	get_node("../Explosion").visible = true
	await get_tree().create_timer(0.5).timeout
		
	get_tree().change_scene_to_file("res://ui.tscn")
