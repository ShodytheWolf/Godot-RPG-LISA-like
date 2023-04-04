# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(stateName)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initialState := NodePath()

# The current active state. At the start of the game, we get the `initial_state`.
@onready var state: State = get_node(initialState)

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.stateMachine = self;
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func transition_to(targetStateName: String, msg: Dictionary = {})-> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(targetStateName):
		return
	
	state.exit()
	state = get_node(targetStateName)
	state.enter(msg)
	emit_signal("transitioned", state.name);
