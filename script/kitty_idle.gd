extends State
class_name KittyIdle

var min_speed = 1
var max_speed = 2
var countdown

@export var kitty: CharacterBody2D
@export var velocity = randi_range(min_speed,max_speed)

func _ready() -> void:
	velocity = randi_range(min_speed,max_speed)
	countdown = randf_range(1.0,5.0)

func Enter():
	#kitty.play("Idle_" + str(randi_range(1,4)))
	kitty.rotation = 0
	randomize_wander()
	
func randomize_wander():
	
	await get_tree().create_timer(randi_range(5,30)).timeout
	velocity = randi_range(min_speed,max_speed)
	#random_location = Vector2(randf_range(0,1000),(randf_range(0,600)))
	#print(random_location)

func Update(delta):
	if countdown > 0:
		countdown -= delta
	else:
		randomize_wander()
	
func Physics_Update(delta):
	if kitty:
		kitty.velocity = velocity
