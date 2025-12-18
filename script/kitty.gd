extends AnimatedSprite2D
@onready var button: Button = $Button
@onready var sfx_meow: AudioStreamPlayer = $SFXMeow
@onready var sfx_camera: AudioStreamPlayer = $SFXCamera


@export var object_to_spawn: PackedScene
@export var target = null
var consume_amount 
var min_consume_amount = 5
		
func _ready() -> void:
	target = get_parent().get_node("CatnipStack")

func _on_button_pressed() -> void:
	Globals.pics += 1
	if randf() < 0.3:#less than 10% chance
		sfx_camera.play()
	if randf() < 0.02:
		sfx_meow.play()
		
	var instance = object_to_spawn.instantiate()
	add_child(instance)
	var scale_factor = randf_range(0.1,0.15)
	var offset_factor = randf_range(-10,10)
	instance.global_position = global_position + Vector2(offset_factor,offset_factor)
	instance.scale = Vector2(scale_factor,scale_factor)

func _process(delta: float) -> void:
	if self.get_owner() and self.get_owner().name == "Main":
		print("Node is in MyScene")
	#
#func _on_hitbox_area_entered(area: Area2D) -> void:
	#consume_amount= minf(2* Globals.dps, min_consume_amount) 
	#velocity = 0
	#state.EATING
	#while Globals.catnip >= 0:
		#await get_tree().create_timer(1.0).timeout
		#Globals.catnip -= consume_amount
	#state.WALKING
