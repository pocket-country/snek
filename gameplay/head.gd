class_name Head extends SnakePart

# different textures different directions
var snh_tx_up:Texture = preload("res://gameplay/sprites/snHeadUp.png")
var snh_tx_dn:Texture = preload("res://gameplay/sprites/snHeadDn.png")
var snh_tx_rt:Texture = preload("res://gameplay/sprites/snHeadRt.png")
var snh_tx_lf:Texture = preload("res://gameplay/sprites/snHeadLf.png")

signal food_eaten
signal collided_with_tail

func _ready() -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		food_eaten.emit()
		area.call_deferred("queue_free")
	else:
		# cause currently there is nothing else it could be ... but in the future!
		collided_with_tail.emit()
		
func set_heading(dir):
	match dir:
		"U":
			$HDSprite2d.texture = snh_tx_up
		"D":
			$HDSprite2d.texture = snh_tx_dn
		"L":
			$HDSprite2d.texture = snh_tx_lf
		"R":
			$HDSprite2d.texture = snh_tx_rt
