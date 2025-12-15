extends Node2D
var pieces_per_click = 1 # with max 50
@export var popup: PackedScene
@onready var catnip_particles: GPUParticles2D = $CatnipParticles



func _on_click_button_pressed() -> void:
	spawn_catnip()
	var instance = popup.instantiate()
	add_child(instance) #pos relative to parent
	instance.global_position = Vector2(600,200)
	instance.scale = Vector2(3.0,3.0)

func spawn_catnip():
	var p = preload("res://scenes/catnip_particles.tscn").instantiate()
	p.amount = min(15,GameData.clickpower)
	p.global_position = get_global_mouse_position()
	p.emitting = true
	add_child(p)
	
