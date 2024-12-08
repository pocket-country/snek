class_name Tail extends SnakePart

@export var textures:Array[Texture]
@onready var tailsprite: Sprite2D = $Sprite2D

func _ready() -> void:
	tailsprite.texture = textures.pick_random()
	
