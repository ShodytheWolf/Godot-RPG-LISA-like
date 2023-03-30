extends CanvasLayer

#@export (String, FILE, "*.json") var sceneTextFile
#ref to json
@export_file("*.json") var sceneTextFile : String


#Dictionary object of ALL the text the JSON key-pair gave you
var sceneText = {};

#Array of text currently being used by the DialogPlayer
var selectedText = [];

#is DialogPlayer still displaying text?
var inProgress = false;

#ref to GUI
@onready var background = $Background
@onready var textLabel = $TextLabel

func _ready():
	background.visible = false;
	sceneText = load_scene_text();
	SignalBus.display_dialog.connect(on_display_dialog)
	#SignalBus.connect("display_dialog", self, "on_display_dialog")


func load_scene_text():
		#if file.file_exists(sceneTextFile):
	if FileAccess.file_exists(sceneTextFile):
		var file = FileAccess.open(sceneTextFile,FileAccess.READ)
		
		return JSON.parse_string(file.get_as_text())


func on_display_dialog(text_key):
	if inProgress:
		next_line()
	else:
		get_tree().paused = true;
		background.visible = true;
		inProgress = true;
		selectedText = sceneText[text_key].duplicate()
		show_text()
		#añadir recursión para evitar re-llamar al evento "display_dialog"

func next_line():
	if selectedText.size() > 0:
		show_text()
	else:
		finish()

func show_text():
	textLabel.text = selectedText.pop_front()

func finish():
	textLabel.text = "";
	background.visible = false;
	inProgress = false;
	SignalBus.emit_signal("finished_dialog")
	get_tree().paused = false;
