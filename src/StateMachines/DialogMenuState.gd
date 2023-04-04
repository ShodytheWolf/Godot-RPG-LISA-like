extends State

@onready var dialogo = load("res://Prefabs/Dialog/DialogPlayer.tscn")

func enter(_msg := {}) -> void:
	SignalBus.finished_dialog.connect(transition_to_idle)
	dialogo.instantiate();
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func transition_to_idle() -> void:
	dialogo.queue_free()
	stateMachine.transition_to("Idle")
	pass
