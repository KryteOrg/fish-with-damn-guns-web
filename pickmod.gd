extends Button

func _on_pressed() -> void:
	get_node("../../FileDialog").show()
