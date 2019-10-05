extends StaticBody2D

onready var collider = $"CollisionShape2D"
onready var sprite = $"AnimatedSprite"

func _process(delta):
	pass
	
func open():
	sprite.animation = "open"
	collider.disabled = true

func close():
	sprite.animation = "close"
	collider.disabled = false
