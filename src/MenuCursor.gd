extends TextureRect

@export var menuParentPath : NodePath;

@export var cursorOffset : Vector2;

@onready var menuParent := get_node(menuParentPath);


var cursorIndex : int = 0;

func _process(_delta):
	var input := Vector2.ZERO;
	
	if Input.is_action_just_pressed("ui_up"):
		input.y -= 1
	if Input.is_action_just_pressed("ui_down"):
		input.y += 1
	if Input.is_action_just_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_just_pressed("ui_right"):
		input.x += 1
	
	if menuParent is VBoxContainer:
		set_cursor_from_index(cursorIndex + input.y)
		
	elif menuParent is HBoxContainer:
		set_cursor_from_index(cursorIndex + input.x)
		
	elif menuParent is GridContainer:
		set_cursor_from_index(cursorIndex + input.x + input.y * menuParent.columns)
	
	if Input.is_action_just_pressed("ui_accept"):
		var currentMenuItem := get_menu_item_at_index(cursorIndex)
		if currentMenuItem != null:
			if currentMenuItem.has_method("cursor_select"):
				currentMenuItem.cursor_select()

func get_menu_item_at_index(index : int) -> Control:
	if menuParent == null:
		return null

	if index >= menuParent.get_child_count() or index < 0:
		return null
	
	return menuParent.get_child(index) as Control

func set_cursor_from_index(index : int) -> void:
	var menuItem := get_menu_item_at_index(index);
	
	if menuItem == null:
		return

	var position = menuItem.global_position
	var size = menuItem.size
	
	global_position = Vector2(position.x, position.y + size.y / 2.0) - (size / 2.0) - cursorOffset
	
	cursorIndex = index;
