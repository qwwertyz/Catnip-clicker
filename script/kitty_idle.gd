extends State
class_name KittyIdle


var countdown

@export var kitty: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D


func Enter():
	countdown = randf_range(5.0,30.0)
	animated_sprite.play("Idle_" + str(randi_range(1,4)))
	kitty.rotation = 0


func Update(delta):
	if countdown > 0:
		countdown -= delta
	else:
		Transitioned.emit(self,"KittyWalk")
