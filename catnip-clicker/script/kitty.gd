extends CharacterBody2D
@onready var button: Button = $Button

var min_speed = 80
var max_speed = 100

func _ready() -> void:
	velocity.x = randi_range(min_speed,max_speed)
	
var wiggle_amount := 0.1   # max rotation in radians (~5.7 degrees)
var wiggle_speed := 1.0   # speed of wobble        # set to true when moving

func _process(_delta):
	rotation = wiggle_amount * sin(Time.get_ticks_msec() / 100.0 * wiggle_speed)
	move_and_slide()
	
func _on_button_pressed() -> void:
	GameData.pics += 1
