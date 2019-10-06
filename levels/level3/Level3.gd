extends Node2D

onready var rec_mul = $"receivers/ReceiverMulti"
onready var goal = $Goal

var win_condition = {69: true, 76: true}
onready var Note = preload("res://logic/note.gd").Note

onready var sfx_howl = preload("res://audio/sfx/howl01_A.ogg")

func _ready():
	# add howl for each note required for activating the goal	
	var base_volume = linear2db(1.0/win_condition.size())
	for midi_note_number in win_condition.keys():
		var n = Note.new(midi_note_number)
		var asp = PlayerAttenuatingAudioStreamPlayer.new()
		asp.set_params(base_volume, 128, 1)
		asp.stream = sfx_howl
		asp.pitch_scale = n.well_tempered_factor_from_concert_pitch()
		goal.add_child(asp)

func _process(delta):	
	var success = rec_mul.inputs.size() == 2 and 69 in rec_mul.inputs and 76 in rec_mul.inputs
	if success:
		goal.set_enabled(true)
		$Traces.modulate = Globals.TRACE_ACTIVATED
	else:
		goal.set_enabled(false)
		$Traces.modulate = Globals.TRACE_DEACTIVATED
	
	rec_mul.inputs.clear()