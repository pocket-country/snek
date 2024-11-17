class_name Bounds extends Node2D

@onready var upper_left: Marker2D = %UpperLeft
@onready var lower_right: Marker2D = %LowerRight

var x_max:float
var x_min:float
var y_max:float
var y_min:float

func _ready() -> void:
	# copy into shorter vars for readability typeability
	x_max = lower_right.position.x
	x_min = upper_left.position.x
	y_max = lower_right.position.y
	y_min = upper_left.position.y
	
func wrap_vector(v:Vector2)-> Vector2:
	# OK.  What about at the corner?  Are we ever moving diagonally?
	# and what about a switch statement? see match.  Why does everyone love ELIF? Fucking python.
	# ACtHuaLLy we don't need elif because return!
	if v.x > x_max:
		return Vector2(x_min, v.y)
	if v.x < x_min:
		return Vector2(x_max, v.y)
	if v.y > y_max:
		return Vector2(v.x, y_min)
	if v.y < y_min:
		return Vector2(v.x, y_max)
	return v
	
		
