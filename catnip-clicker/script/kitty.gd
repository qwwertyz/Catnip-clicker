extends Sprite2D
@onready var button: Button = $Button
@onready var hitbox: Area2D = $Hitbox

var target: Node2D = null

var min_speed = 80
var max_speed = 100
var wiggle_amount := 0.1   # max rotation in radians (~5.7 degrees)
var wiggle_speed := 1.0   # speed of wobble        # set to true when moving
var velocity # velocity only usable in characterbody 2d
var consume_amount 
var min_consume_amount = 5
enum state{IDLE, WALKING, EATING}

func _ready() -> void:
	velocity = randi_range(min_speed,max_speed)
	target = get_parent().get_node("CatnipStack")
	

func _process(delta):
	if state.WALKING:
		rotation = wiggle_amount * sin(Time.get_ticks_msec() / 100.0 * wiggle_speed)
		
		var dir := (target.global_position - global_position)
		position += dir.normalized() * velocity * delta
		if global_position.distance_to(target.global_position) < 5.0:
			state.EATING
	
func _on_button_pressed() -> void:
	GameData.pics += 1
	
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	consume_amount= minf(2* GameData.dps, min_consume_amount) 
	velocity = 0
	state.EATING
	while GameData.catnip >= 0:
		await get_tree().create_timer(1.0).timeout
		GameData.catnip -= consume_amount
	state.WALKING
