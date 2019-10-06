extends StaticBody2D
# TODO rename this class to SingleReceiver or something

# export MIDI note as int, but create Note object at runtime
export var midi_note_number : int = 69
onready var note = preload("res://logic/note.gd").Note.new(midi_note_number)

onready var asp = $AudioStreamPlayer

const BASE_VOLUME_DB = 0
const MAX_HEARABLE_DISTANCE = 200
const ATTENUATION = 2

var inputs = {}
var call = 0

func _ready():
	asp.pitch_scale = note.well_tempered_factor_from_concert_pitch()
	asp.play()

func _process(delta):	
	if call % Globals.AUDIO_UPDATE_FREQ == 0:
		# taking some inspiration from audio_stream_player_2d.cpp
		var distance_to_player = global_position.distance_to(Globals.player.global_position)
		var multiplier = pow(1.0 - distance_to_player / MAX_HEARABLE_DISTANCE, ATTENUATION)
		multiplier *= db2linear(BASE_VOLUME_DB)
		asp.volume_db = linear2db(multiplier)
	call = (call + 1) % Globals.AUDIO_UPDATE_FREQ