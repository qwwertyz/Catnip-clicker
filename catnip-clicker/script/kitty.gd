extends AnimatedSprite2D
@onready var button: Button = $Button

var target: Node2D = null

enum state{IDLE, WALKING, EATING}

var min_speed = 80
var max_speed = 100
var wiggle_amount := 0.1   # max rotation in radians (~5.7 degrees)
var wiggle_speed := 1.0   # speed of wobble        # set to true when moving
var random_location = Vector2(1038,559)
var direction
var distance
var velocity # velocity only usable in characterbody 2d

var consume_amount 
var min_consume_amount = 5


func _ready() -> void:
	state.WALKING
	velocity = randi_range(min_speed,max_speed)
	target = get_parent().get_node("CatnipStack")
	

func _process(delta):
	if state.WALKING:
		play("Walk")
		rotation = wiggle_amount * sin(Time.get_ticks_msec() / 100.0 * wiggle_speed)
		direction = random_location - global_position
		distance = direction.length()
		global_position += direction.normalized() * velocity * delta
		if distance < 50.0:
			state.IDLE
			
	if state.IDLE:
		play("Idle")
		await get_tree().create_timer(randi_range(5,30)).timeout
		velocity = randi_range(min_speed,max_speed)
		random_location = Vector2(randf_range(0,630),(randf_range(0,1100)))
		state.WALKING
		
		
		
	
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
