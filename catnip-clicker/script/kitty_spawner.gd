extends Node2D
var certainamt = 100
#@export var object_to_spawn: PackedScene
#
#func _process(_delta: float) -> void:
	#if Main.lifetime_earnings > certainamt:
		#Main.lifetime_earnings -= certainamt
		#certainamt *= 1.5
		#spawn
	#var instance = object_to_spawn.instantiate()
	#add_child(instance)
	#instance.position = Vector2(-20,randi_range(588,590))
