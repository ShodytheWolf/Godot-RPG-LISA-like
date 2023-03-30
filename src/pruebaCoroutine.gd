extends Node2D

var i : int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	coroutine()
	
	pass # Replace with function body.


func coroutine():
	while true:
		await get_tree().create_timer(0.5).timeout
		print(i)
		i += 1
	pass
