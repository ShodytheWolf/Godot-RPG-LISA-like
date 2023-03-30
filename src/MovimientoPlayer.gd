extends CharacterBody2D

const UP_DIRECTION := Vector2.UP

@export var speed := 300.0
@export var levitateVelocity := 3.0
var maximumJumps := 1
var jumpsMade := 0
@export var tiempoDesdeSalto = Timer.new();


@export var jumpHeight : float
@export var jumpTimeToPeak : float
@export var jumpTimeToDescent : float

@onready var jumpVelocity : float = ((2.0 * jumpHeight) / jumpTimeToPeak) * -1.0
@onready var jumpGravity : float = ((-2.0 * jumpHeight) / jumpTimeToPeak * jumpTimeToPeak) * -1.0
@onready var fallGravity : float = ((-2.0 * jumpHeight) / jumpTimeToDescent * jumpTimeToDescent) * -1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	tiempoDesdeSalto.autostart = true;
	tiempoDesdeSalto.wait_time = 0.1;

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

#--------------------------PROCESADO DE FISICAS---------------------------------------------------
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = true; # ACA TA LA COSA MEPA
	
	velocity.y += getGravity() * delta;
	velocity.x = getInputVelocity() * speed;
	
	if is_on_floor():
		tiempoDesdeSalto.start( 0.1)	
	
	if is_jumping() or (not tiempoDesdeSalto.is_stopped() and Input.is_action_just_pressed("ui_up")):
		jump()
		tiempoDesdeSalto.stop()
	elif Input.is_action_pressed("ui_up") and not is_falling():
		levitate() 
	
	move_and_slide()
	pass


#----------------------CONTROL DE INPUTS---------------------------------------------------------
func is_falling() -> bool:
	if velocity.y > 0.0 and not is_on_floor():
		return true
	else:
		return false

func is_jumping() -> bool:
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		return true
	else:
		return false

func is_jump_cancelled() -> bool:
	if Input.is_action_just_released("ui_up") and velocity.y < 0.0:
		return true
	else:
		return false

func getGravity() -> float:
	return jumpGravity if velocity.y < 0.0 else fallGravity

func jump():
	velocity.y = jumpVelocity;

func levitate():
	velocity.y -= levitateVelocity;

func getInputVelocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("run"):
		horizontal -= 1.5
	elif Input.is_action_pressed("ui_left"):
		horizontal -= 1.0


	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("run"):
		horizontal += 1.5
	elif Input.is_action_pressed("ui_right"):
		horizontal += 1.0

	return horizontal
