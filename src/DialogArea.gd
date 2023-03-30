extends Area2D

#exporta la llave del .json setteable en el editor
@export var dialog_key = ""

#"flag to set if the player has entered the area or not"
var areaActive = false;

func _input(event):
	if areaActive and event.is_action_pressed("ui_accept"):
		SignalBus.emit_signal("display_dialog",dialog_key); #emito la señal "display_dialog" con dialog_key de parametro


func _on_area_entered(area):
	print("uwu entre");
	areaActive = true;


func _on_area_exited(area):
	print("uwu sali");
	areaActive = false;
