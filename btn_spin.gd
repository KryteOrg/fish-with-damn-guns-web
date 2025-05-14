extends Button

var tweens = []

func _process(delta: float) -> void:
	pivot_offset = size / 2

func _on_mouse_entered() -> void:
	get_node("../Slip").pitch_scale = randf_range(0.7,1.2)
	
	get_node("../Slip").play()
	
	var tween = create_tween() 

	tween.tween_property(self, "rotation", rotation + deg_to_rad(360), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	
	tweens.append(tween)
	
func _on_mouse_exited() -> void:
	for tween in tweens:
		if tween: 
			tween.kill()  
	
	rotation = 0
	
