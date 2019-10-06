extends Node2D

var asp
onready var sprite = $Sprite
onready var sfx_buzz01 = preload("res://audio/sfx/buzz01_A.ogg")
onready var sfx_buzz02 = preload("res://audio/sfx/buzz02_A.ogg")

# TODO compute distance via https://gamedev.stackexchange.com/questions/44483/how-do-i-calculate-distance-between-a-point-and-an-axis-aligned-rectangle and set audio volume

func _ready():
	asp = $PlayerAttenuatingAudioStreamPlayer
	asp.stream = sfx_buzz01
	
func set_midi_note(note):
	asp.pitch_scale = note.well_tempered_factor_from_concert_pitch()

func aim_at(to_vec2_global):
	if to_vec2_global == null:
		sprite.scale.x = 0
	else:
		sprite.scale.x = (global_position - to_vec2_global).length()