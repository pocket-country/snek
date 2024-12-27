extends CanvasLayer

@onready var head_scene:PackedScene = preload("res://gameplay/head.tscn")
var head:Head

var max_frames: int = 30
var frames: int = 0
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# instantiate the head - somehow this happens magically when we create the variable.  I guess
	# cause we set its value to a scene (aka a node)
	head = head_scene.instantiate() as Head
	head.position = $StartPoint.position
	add_child(head)
	#tail_added.emit(tail)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	frames = frames + 1
	if frames <= max_frames:
		head.position.x = head.position.x + 3
