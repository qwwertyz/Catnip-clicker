extends CharacterBody2D

var min_speed = 280
var max_speed =300

func _ready() -> void:
	velocity.x = randi_range(min_speed,max_speed)
func _physics_process(_delta: float) -> void:
	
	
	#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	
