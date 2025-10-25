extends AnimatedSprite2D
@onready var button: Button = $Button
@onready var sfx_meow: AudioStreamPlayer = $SFXMeow
@onready var sfx_camera: AudioStreamPlayer = $SFXCamera


@export var object_to_spawn: PackedScene
@export var target = null

enum KittyState{IDLE, WALKING, EATING}
var state = KittyState.WALKING

var min_speed = 1
var max_speed = 2
var wiggle_amount := 0.1   # max rotation in radians (~5.7 degrees)
var wiggle_speed := 1.0   # speed of wobble        # set to true when moving
var random_location: Vector2 = Vector2(1038,559)
var direction
var distance
var velocity # velocity only usable in characterbody 2d

var consume_amount 
var min_consume_amount = 5


func _ready() -> void:
	velocity = randi_range(min_speed,max_speed)
	target = get_parent().get_node("CatnipStack")
	enter_state()
func _process(delta: float) -> void:
	match state:
		KittyState.WALKING:
			rotation = wiggle_amount * sin(Time.get_ticks_msec() / 100.0 * wiggle_speed)
			direction = random_location - global_position
			distance = direction.length()#while breaks. try not to use outside of process
			if direction.x < 0:
				if direction.y > 0:#remember godot y is switched
					play("Walk_SW")
				else:
					play("Walk_NW")
			elif direction.x > 0:
				if direction.y > 0:
					play("Walk_SE")
				else:
					play("Walk_NE")
			global_position += direction.normalized() * velocity
			if global_position.distance_to(random_location) < 5.0:
				state = KittyState.IDLE
				enter_state()
				
			
func enter_state():
	match state:
		KittyState.IDLE:
			play("Idle_" + str(randi_range(1,4)))
			rotation = 0
			await get_tree().create_timer(randi_range(5,30)).timeout
			velocity = randi_range(min_speed,max_speed)
			random_location = Vector2(randf_range(0,600),(randf_range(0,1000)))
			#print(random_location)
			state = KittyState.WALKING
			enter_state()
	
func _on_button_pressed() -> void:
	GameData.pics += 1
	if randf() < 0.4:#less than 10% chance
		sfx_camera.play()
	if randf() < 0.02:
		sfx_meow.play()
		
	var instance = object_to_spawn.instantiate()
	add_child(instance)
	var scale_factor = randf_range(0.1,0.15)
	var offset_factor = randf_range(-10,10)
	instance.global_position = global_position + Vector2(offset_factor,offset_factor)
	instance.scale = Vector2(scale_factor,scale_factor)

	
	
	#
#func _on_hitbox_area_entered(area: Area2D) -> void:
	#consume_amount= minf(2* GameData.dps, min_consume_amount) 
	#velocity = 0
	#state.EATING
	#while GameData.catnip >= 0:
		#await get_tree().create_timer(1.0).timeout
		#GameData.catnip -= consume_amount
	#state.WALKING
