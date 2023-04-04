extends State

func enter(_msg := {}) -> void:
	SignalBus.display_dialog.connect(transition_to_dialog)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Llamado a transicionar al State "Dialog"
func transition_to_dialog():
	stateMachine.transition_to("Dialog")
	pass
