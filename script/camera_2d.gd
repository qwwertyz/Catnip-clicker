extends Camera2D
@export var strength_normal = 5
@export var strength_crit = 30
@export var shakeFade: float = 5.0

var shake_strength: float = 0.0
var rng = RandomNumberGenerator.new()

	
func _process(delta: float) -> void:
	if shake_strength >0:
		shake_strength = lerpf(shake_strength,0,shakeFade*delta)
		offset = randomOffset()
func randomOffset():
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))

func _on_clickpower_upgrade_pressed() -> void:
	shake_strength = strength_normal
