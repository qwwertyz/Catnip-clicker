extends Area2D

@export var min_scale: float = 0.7
@export var max_scale: float = 1.2
@export var scale_exponent: float = 0.5   # 1 = linear, <1 = faster growth early, >1 = slower growth early
@export var scale_smooth_factor: float = 0.1
@export var catnip_max: float = 1000      # maximum reference catnip for scaling

var additionalscale = 0.0:
	set(value):
		clampf(additionalscale,0,1)
		

func _ready():
	GameData.catnip_changed.connect(_on_catnip_changed)
	# Initialize scale
	_on_catnip_changed(GameData.catnip)

func _process(delta):
	# Optional: continuously smooth toward target scale
	var target_scale = _calculate_scale(GameData.catnip)
	scale = scale.lerp(Vector2.ONE * target_scale, scale_smooth_factor)


func _on_catnip_changed(new_value: float) -> void:
	var target_scale = _calculate_scale(new_value)
	scale = scale.lerp(Vector2.ONE * target_scale, scale_smooth_factor)

func _calculate_scale(catnip_amount: float) -> float:
# Clamp fraction between 0 and 1
	var fraction = clamp(catnip_amount / catnip_max, 0, 1)
		# Apply optional non-linear scaling
	return min_scale + (max_scale - min_scale) * pow(fraction, scale_exponent)


	
