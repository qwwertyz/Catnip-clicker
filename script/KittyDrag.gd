extends State
class_name KittyDrag

@export var kitty: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

func Enter():
	animated_sprite.play("Drag")
