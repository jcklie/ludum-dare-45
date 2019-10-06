extends StaticBody2D
# TODO rename this class to SingleReceiver or something

# export MIDI note as int, but create Note object at runtime
export var midi_note_number : int = 69
onready var note = preload("res://logic/note.gd").Note.new(midi_note_number)

onready var asp = $PlayerAttenuatingAudioStreamPlayer

var inputs = {}

func _ready():
	asp.set_params(0.0, 150.0, 1.0)
	asp.pitch_scale = note.well_tempered_factor_from_concert_pitch()
