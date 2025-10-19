extends CharacterBody2D

var min_speed = 80
var max_speed = 100

func _ready() -> void:
	velocity.x = randi_range(min_speed,max_speed)
func _physics_process(_delta: float) -> void:
	
	move_and_slide()

	


func _on_button_pressed() -> void:
	pass # Replace with function body.
