extends Node2D

onready var Note = preload("res://logic/note.gd").Note

# common to all notes
var _samples = []
var _base_volume_db = 0
var _max_hearable_distance = 150
var _attenuation = 1

var _notes = {}

func set_params(samples, base_volume_db, max_hearable_distance, attenuation):
	self._samples = samples
	self._base_volume_db = base_volume_db
	self._max_hearable_distance = max_hearable_distance
	self._attenuation = attenuation
	
func set_notes(notes):
	# if new notes match current notes: nop
	if _notes.has_all(notes) and _notes.size() == notes.size():
		return
	
	# clear existing samples
	for child in get_children():
		child.queue_free()
	
	# scale down each sample's volume according to the level of polyphony
	var volume = linear2db(db2linear(_base_volume_db) * 1.0/notes.size())
	
	for midi_note_number in notes:
		var n = Note.new(midi_note_number)
		var asp = PlayerAttenuatingAudioStreamPlayer.new()
		asp.set_params(volume, self._max_hearable_distance, self._attenuation)
		
		# pick sample at random
		var sample = self._samples[randi() % self._samples.size()]
		asp.stream = sample
		
		asp.pitch_scale = n.well_tempered_factor_from_concert_pitch()
		self.add_child(asp)

	# keep notes for next call
	for note in notes:
		self._notes[note] = true

func set_enabled(enabled):
	if enabled:
		for asp in get_children():
			if not asp.playing:
				asp.play()
	else:
		for asp in get_children():
			if asp.playing:
				asp.stop()