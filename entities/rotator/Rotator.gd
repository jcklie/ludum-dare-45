extends Node2D

onready var asp = $AudioStreamPlayer
onready var sfx_rotate = preload("res://audio/sfx/rotate_emitter.wav")

func _ready():
	asp.stream = sfx_rotate

func do_rorate(obj, source, target, duration):
	if $Tween.is_active():
		return
		
	$Tween.interpolate_property(obj, 
		"global_rotation_degrees",
		source, target, duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	asp.play()