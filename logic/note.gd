extends Node

class Note:
	# A, 440Hz is 69, see https://www.inspiredacoustics.com/en/MIDI_note_numbers_and_center_frequencies
	const A_CONCERT_PITCH = 69

	var _midi_note_number
	
	func _init(midi_note_number):
		self._midi_note_number = midi_note_number as int
	
	func sharp():
		return Note.new(self._midi_note_number + 1)
	
	func flat():
		return Note.new(self._midi_note_number - 1)
	
	func well_tempered_factor_from_concert_pitch():
		# minor second to major seventh, see https://de.wikipedia.org/wiki/Gleichstufige_Stimmung
		var well_tempered_intervals = [1.059463, 1.122462, 1.189207, 1.259921, 1.334840, 1.414214, 1.498307, 1.587401, 1.681793, 1.781797, 1.887749]
		
		var factor = 1.0
		var m = self._midi_note_number
		if m > A_CONCERT_PITCH:
			var octaves = (m - A_CONCERT_PITCH) / 12
			var rem = (m - A_CONCERT_PITCH) % 12
			
			factor *=  pow(2, octaves)
			factor *= well_tempered_intervals[rem]
		return factor