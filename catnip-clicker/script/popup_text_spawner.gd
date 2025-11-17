extends Node2D
var pieces_per_click = 1 # with max 50
@export var popup: PackedScene
@export var catnip_particles: PackedScene



func _on_click_button_pressed() -> void:
	spawn_catnip(global_position)
	var instance = popup.instantiate()
	add_child(instance) #pos relative to parent
	instance.global_position = Vector2(600,200)
	instance.scale = Vector2(3.0,3.0)

func spawn_catnip(pos: Vector2):
	pieces_per_click = GameData.clickpower
	for i in pieces_per_click:
		var piece = catnip_particles.instantiate()
		add_child(piece)
		piece.global_position = pos
