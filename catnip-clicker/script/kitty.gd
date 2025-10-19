extends CharacterBody2D
@onready var button: Button = $Button

var min_speed = 80
var max_speed = 100

func _ready() -> void:
	velocity.x = randi_range(min_speed,max_speed)
	
func _physics_process(_delta: float) -> void:
	rotation = -15.0
	await get_tree().create_timer(1.0).timeout
	rotation = 15.0
	await get_tree().create_timer(1.0).timeout
	move_and_slide()

	
func _on_button_pressed() -> void:
	Main.pics += 1
	Main.pics_label.text = "Pics: " + str(roundf(Main.pics))
