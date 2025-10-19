extends Node2D
var certainamt = 50.0
var tutorial = true
@export var object_to_spawn: PackedScene
@onready var label: Label = $Label

func _process(_delta: float) -> void:
	if Main.lifetime_earnings >= certainamt:
		Main.lifetime_earnings -= certainamt
		certainamt *= 1.5
		var instance = object_to_spawn.instantiate()
		add_child(instance)
		instance.position = Vector2(-200,randi_range(2100,2300))
		instance.scale = Vector2(1,1)
		
		if tutorial:
			label.visible = true
			await get_tree().create_timer(5.0).timeout
			label.visible = false
			tutorial = false
