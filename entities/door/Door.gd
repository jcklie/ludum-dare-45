extends StaticBody2D

onready var collider = $"CollisionShape2D"
onready var sprite = $"AnimatedSprite"

var is_open = false

func _ready():
	sprite.connect("animation_finished", self, "_on_animation_finished")
	
func open():
	if not is_open and not sprite.playing:
		is_open = true
		sprite.play("open")

func close():
	if is_open and not sprite.playing:
		is_open = false
		sprite.play("close")

	
func _on_animation_finished():
	collider.disabled = is_open
	sprite.playing = false
