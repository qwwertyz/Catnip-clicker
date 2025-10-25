extends Node2D
var certainamt = 50.0
var tutorial = true
@export var object_to_spawn: PackedScene
@onready var label: Label = $Label

@export var base_catnip: float = 300
@export var cat_multiplier: float = 3.92
@export var max_cats: int = 10
var current_cats = 0

func catnip_required_for_cat(n: int) -> float:
	# n is 1-based index of cat, first cat around 300, last 1 billion
	return base_catnip * pow(cat_multiplier, n - 1)
	
func max_cats_unlocked() -> int:
	for n in range(1, max_cats + 1):
		if GameData.lifetime_earnings < catnip_required_for_cat(n):
			return n - 1
	return max_cats

func _ready() -> void:
	GameData.lifetime_changed.connect(on_lifetime_changed)
	
func on_lifetime_changed(value):
	
	if current_cats < max_cats_unlocked():
		print("spawning cat at lifetime earning of " + str(value))
		var instance = object_to_spawn.instantiate()
		add_child(instance)
		instance.position = Vector2(200,randi_range(2100,2300))
		current_cats += 1
	
		if tutorial:
			label.visible = true
			await get_tree().create_timer(5.0).timeout
			label.visible = false
			tutorial = false

	
