extends Node2D

export(bool) var enabled = true
onready var asp = $PlayerAttenuatingAudioStreamPlayer
onready var sprite = $Sprite
onready var sfx_buzz01 = preload("res://audio/sfx/buzz01_A.ogg")
onready var sfx_buzz02 = preload("res://audio/sfx/buzz02_A.ogg")

# TODO compute distance via https://gamedev.stackexchange.com/questions/44483/how-do-i-calculate-distance-between-a-point-and-an-axis-aligned-rectangle and set audio volume

func _ready():
	set_enabled(enabled)
	
func set_midi_note(note):
	asp.pitch_scale = note.well_tempered_factor_from_concert_pitch()

func aim_at(to_vec2_global):
	sprite.scale.x = (global_position - to_vec2_global).length()

func set_enabled(enabled):
	if enabled:
		sprite.visible = true
		if not asp.playing:
			asp.stream = sfx_buzz01
			asp.play()
	else:
		sprite.visible = false
		if asp.playing:
			asp.stop()