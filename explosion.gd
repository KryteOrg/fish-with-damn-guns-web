extends TextureRect

func _ready() -> void:
	get_node("../Explosion").visible = false

func _process(delta: float) -> void:
	pivot_offset = size / 2
