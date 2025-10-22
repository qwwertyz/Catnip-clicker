extends AnimatedSprite2D
@onready var button: Button = $Button

var target: Node2D = null

enum KittyState{IDLE, WALKING, EATING}
var state = KittyState.WALKING

var min_speed = 1
var max_speed = 2
var wiggle_amount := 0.1   # max rotation in radians (~5.7 degrees)
var wiggle_speed := 1.0   # speed of wobble        # set to true when moving
var random_location = Vector2(1038,559)
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
			play("Walk")
			rotation = wiggle_amount * sin(Time.get_ticks_msec() / 100.0 * wiggle_speed)
			direction = random_location - global_position
			distance = direction.length()#while breaks. try not to use outside of process
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
			print(random_location)
			state = KittyState.WALKING
			enter_state()
	
func _on_button_pressed() -> void:
	GameData.pics += 1
	
	#
#func _on_hitbox_area_entered(area: Area2D) -> void:
	#consume_amount= minf(2* GameData.dps, min_consume_amount) 
	#velocity = 0
	#state.EATING
	#while GameData.catnip >= 0:
		#await get_tree().create_timer(1.0).timeout
		#GameData.catnip -= consume_amount
	#state.WALKING
