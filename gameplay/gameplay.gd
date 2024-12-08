class_name Gameplay extends Node2D

const gameover_scene:PackedScene = preload("res://menus/game_over.tscn")
var gameover_menu:GameOver

# vars to hold scenes (like snek head) note strong type declarations (class def in head script)
@onready var head: Head = %Head as Head
@onready var bounds: Bounds = %Bounds as Bounds
@onready var spawner: Node2D = %Spawner as Spawner


# tick tock intervals for constant snek movement
var time_between_moves:float = 1000.0
var time_since_last_move:float = 0.0
var speed:float = 5000.0
var snake_ticks:int = 0

var move_dir:Vector2 = Vector2.RIGHT

var snake_parts:Array[SnakePart] = []

var score:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# so that we start right away
	time_since_last_move = time_between_moves
	
	#connect some signals from other scenes
	head.food_eaten.connect(_on_food_eaten)
	head.collided_with_tail.connect(_on_collided_with_tail)
	
	spawner.tail_added.connect(_on_tail_added)
	
	# make our first little nibble
	spawner.spawn_food()
	# add the head to our snake parts array
	# I guess we don't instantiate it like the others as it is arady added to the gameplay scene manually when we built this thing
	snake_parts.push_back(head)
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
	# roll through segments updating tail position
	for i in range(1, snake_parts.size(), 1):   # note don't get head at 0
		snake_parts[i].move_to(snake_parts[i - 1].last_position)

func _on_food_eaten():
	# print("gotcha")	
	# Add a tail segment & new food.
	spawner.call_deferred("spawn_food")
	spawner.call_deferred("spawn_tail",snake_parts[snake_parts.size() - 1].last_position)
	
	#bump score
	score += 1
	
	# currently not making it speed up
	#speed += 500;
	
	
func _on_tail_added(tail:Tail):
	snake_parts.push_back(tail)
	
func _on_collided_with_tail():
	# test to see if this has been instantiated already, if not do it.
	# test is actually for null ...
	if not gameover_menu:
		gameover_menu = gameover_scene.instantiate() as GameOver
		add_child(gameover_menu)
		gameover_menu.set_score(score)
	
