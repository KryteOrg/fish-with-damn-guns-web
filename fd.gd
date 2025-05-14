extends FileDialog

func _on_file_selected(path: String) -> void:
	var g = load("res://game.tscn");
	
	g.mod = path

	get_tree().change_scene_to_packed(g)
