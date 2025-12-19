extends Node

@export var initial_state : State
var current_state : State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_Transitioned)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state 		
			
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
		current_state.Physics_Update(delta)#only updates current state.

func on_Transitioned(state, new_state_name):
	if state != current_state:
		return
		
	var key = new_state_name.to_lower()#safety check
	if not states.has(key):
		push_error("State not found: " + key + " | Available: " + str(states.keys()))
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	current_state = new_state
