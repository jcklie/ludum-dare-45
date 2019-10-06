extends Node2D

var enabled = true
onready var sprite = $Sprite
onready var asp2d = $AudioStreamPlayer2D
onready var sfx_buzz01 = preload("res://audio/sfx/buzz01_A.ogg")
onready var sfx_buzz02 = preload("res://audio/sfx/buzz02_A.ogg")

# TODO set note and adjust pitch
# TODO compute distance via https://gamedev.stackexchange.com/questions/44483/how-do-i-calculate-distance-between-a-point-and-an-axis-aligned-rectangle and set audio volume
# TODO less frequent audio updates

func _ready():
	asp2d.stream = sfx_buzz01
	self.set_enabled(true)

func aim_at(to_vec2_global):
	sprite.scale.x = (global_position - to_vec2_global).length()
	
func set_enabled(enabled: bool):
	self.enabled = enabled
	if self.enabled:
		asp2d.play()
	else:
		asp2d.stop()