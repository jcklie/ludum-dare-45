extends StaticBody2D

onready var collider = $"CollisionShape2D"
onready var sprite = $"AnimatedSprite"

var open = false

func _ready():
	sprite.connect("animation_finished", self, "_on_animation_finished")
	
func open():
	if not open and not sprite.playing:
		open = true
		sprite.play("open")

func close():
	if open and not sprite.playing:
		open = false
		sprite.play("close")

	
func _on_animation_finished():
	collider.disabled = open
	sprite.playing = false
