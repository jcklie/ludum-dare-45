extends StaticBody2D

onready var collider = $"CollisionShape2D"
onready var sprite = $"AnimatedSprite"
onready var asp = $AudioStreamPlayer
onready var sfx_open = preload("res://audio/sfx/door_open.wav")
onready var sfx_close = preload("res://audio/sfx/door_close.wav")

var is_open = false

func _ready():
	sprite.connect("animation_finished", self, "_on_animation_finished")
	
func open():
	if not is_open and not sprite.playing:
		is_open = true
		sprite.play("open")
		asp.stream = sfx_open
		asp.play()

func close():
	if is_open and not sprite.playing:
		is_open = false
		sprite.play("close")
		asp.stream = sfx_close
		asp.play()

func _on_animation_finished():
	collider.disabled = is_open
	sprite.playing = false
	asp.stop()
