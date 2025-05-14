extends Control

func _ready():
	await get_tree().create_timer(60).timeout
	get_tree().change_scene_to_file("res://ui.tscn")
