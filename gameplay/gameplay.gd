class_name Gameplay extends Node2D

# holds snek head note strong type declarations (class def in head script)
@onready var head: Head = %Head as Head
@onready var bounds: Bounds = %Bounds as Bounds

# tick tock intervals for constant snek movement
var time_between_moves:float = 1000.0
var time_since_last_move:float = 0.0
var speed:float = 5000.0
var snake_ticks:int = 0

var move_dir:Vector2 = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_up"):
		#print("up up with a fish")
		move_dir = Vector2.UP
	if Input.is_action_pressed("ui_down"):
		#print("put me down said the fish")
		move_dir = Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		#print("bear left under bridge")
		move_dir = Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		#print("might makes right")
		move_dir = Vector2.RIGHT
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

# built in function template, use physics for area2d objects (such as snake parts!)
func _physics_process(delta: float) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_moves:
		update_snake()
		time_since_last_move = 0.0
				
func update_snake():
	snake_ticks += 1
	var new_position:Vector2 = head.position + (move_dir * Global.GRID_SIZE)
	new_position = bounds.wrap_vector(new_position)
	head.move_to(new_position)
	#print("Snake On The Move!", snake_ticks)
	
