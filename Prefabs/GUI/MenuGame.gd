extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false;
	SignalBus.display_dialog.connect(on_displayed_dialog)
	SignalBus.finished_dialog.connect(on_finished_dialog)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.visible == false and Input.is_action_just_pressed("ui_cancel"):
		self.visible = true
	elif Input.is_action_just_pressed("ui_cancel"):
		self.visible = false
		get_tree().paused = false;
	pass

func on_finished_dialog():
	self.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	print("ventana dialogo when paused")
	pass

func on_displayed_dialog(_text_key):
	self.process_mode = Node.PROCESS_MODE_DISABLED
	print("ventana dialogo disabled")
	pass
