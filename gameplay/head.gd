class_name Head extends SnakePart

signal food_eaten
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		food_eaten.emit()
		area.call_deferred("queue_free")
		


func _ready() -> void:
	# let's preload the texture for the snakes head.
	# we have four of them depending on the direction the snake is headed
	var snh_tx_up:Texture = load("res://gameplay/sprites/snHeadDn.png")
	var snh_tx_dn:Texture = load("res://gameplay/sprites/snHeadUp.png")
	var snh_tx_rt:Texture = load("res://gameplay/sprites/snHeadRt.png")
	var snh_tx_lf:Texture = load("res://gameplay/sprites/snHeadLf.png")
