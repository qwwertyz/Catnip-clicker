extends Node2D
var certainamt = 50.0
var tutorial = true
@export var object_to_spawn: PackedScene
@onready var label: Label = $Label


func _ready() -> void:
	pass
	GameData.lifetime_changed.connect(on_lifetime_changed)
#	Main.lifetime_earnings_changed.connect(on_lifetime_change)#is bind necessary
	
func on_lifetime_changed(value):
	if GameData.lifetime_earnings >= certainamt:
		
		#GameData.lifetime_earnings -= certainamt
		certainamt *= 1.75
		print(str(certainamt) + "is needed for next kitty")
		var instance = object_to_spawn.instantiate()
		add_child(instance)
		instance.position = Vector2(-200,randi_range(2100,2300))
		instance.scale = Vector2(1,1)
		
		if tutorial:
			label.visible = true
			await get_tree().create_timer(5.0).timeout
			label.visible = false
			tutorial = false

	
