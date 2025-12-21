extends Sprite2D

func _process(delta: float) -> void:
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(material, 'shader_parameter/shine_progress', 1.0, 0.1).from_current()
	# seccond is time it takes for one time
