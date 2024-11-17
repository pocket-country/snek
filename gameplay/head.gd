class_name Head extends SnakePart

func _ready() -> void:
	# let's preload the texture for the snakes head.
	# we have four of them depending on the direction the snake is headed
	var snh_tx_up:Texture = load("res://gameplay/sprites/snHeadDn.png")
	var snh_tx_dn:Texture = load("res://gameplay/sprites/snHeadUp.png")
	var snh_tx_rt:Texture = load("res://gameplay/sprites/snHeadRt.png")
	var snh_tx_lf:Texture = load("res://gameplay/sprites/snHeadLf.png")
