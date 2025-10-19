extends CharacterBody2D
var certainamt = 300
var min_speed = 280
var max_speed =300

func _process(delta: float) -> void:
	if Main.catnip > certainamt:
		Main.lifetime_earnings -= certainamt
		certainamt *= 1.2


func _physics_process(delta: float) -> void:
	
	velocity.x = Vector2.RIGHT * max_speed
	#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	
