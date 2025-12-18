extends State
class_name KittyWalk

const SPEED = 100
@export var kitty: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
var random_location: Vector2 = Vector2(1038,559)
var wiggle_amount := 0.1   # max rotation in radians (~5.7 degrees)
var wiggle_speed := 1.0   # speed of wobble        # set to true when moving
var direction
var distance
var min_speed = 1
var max_speed = 2
func Enter():
	random_location = Vector2(randf_range(0,1038),randf_range(0,559))

func Physics_Update(delta):
	kitty.rotation = wiggle_amount * sin(Time.get_ticks_msec() / 100.0 * wiggle_speed)
	direction = random_location - kitty.global_position
	distance = direction.length()
	if direction.x < 0:
		if direction.y > 0:#remember godot y is switched
			animated_sprite.play("Walk_SW")
		else:
			animated_sprite.play("Walk_NW")
	elif direction.x > 0:
		if direction.y > 0:
			animated_sprite.play("Walk_SE")
		else:
			animated_sprite.play("Walk_NE")
	if kitty.global_position.distance_to(random_location) < 5.0:
		Transitioned.emit(self, 'KittyIdle')
	else:
		kitty.velocity = direction.normalized() * SPEED
		kitty.move_and_slide()
