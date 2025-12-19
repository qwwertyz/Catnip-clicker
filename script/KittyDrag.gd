extends State
class_name KittyDrag

@export var kitty: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

func Enter():
	animated_sprite.play("Drag")
	offset = owner.global_position - owner.get_global_mouse_position()

func Update(delta):
	Transitioned.emit(self,"KittyWalk")

# keep offset, dragable = true, release change state via characterbody 2d

var offset: Vector2

func Handle_Input(event):

	if event.button_index == MOUSE_BUTTON_LEFT :
		print("Left mouse button")
		Transitioned.emit(self,"KittyDrag")
	if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		Transitioned.emit(self,"KittyWalk")

func Physics_Update(delta):
	kitty.global_position = kitty.get_global_mouse_position() + offset

	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Transitioned.emit(self,"KittyWalk")
