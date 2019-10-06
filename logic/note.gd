extends Node

class Note:
	# A, 440Hz is 69, see https://www.inspiredacoustics.com/en/MIDI_note_numbers_and_center_frequencies
	const A_CONCERT_PITCH = 69

	var m	# MIDI note number is too long
	
	func _init(midi_note_number):
		self.m = midi_note_number as int
	
	func sharp():
		return Note.new(self.m + 1)
	
	func flat():
		return Note.new(self.m - 1)
	
	func well_tempered_factor_from_concert_pitch():
		# unison to major seventh, see https://de.wikipedia.org/wiki/Gleichstufige_Stimmung
		var well_tempered_intervals = [1.0, 1.059463, 1.122462, 1.189207, 1.259921, 1.334840, 1.414214, 1.498307, 1.587401, 1.681793, 1.781797, 1.887749]
		
		var octaves = abs((self.m - A_CONCERT_PITCH) / 12)
		var rem = abs((self.m - A_CONCERT_PITCH) % 12)
		
		var factor = 1.0
		factor *=  pow(2, octaves)
		factor *= well_tempered_intervals[rem]
		
		# if target pitch is lower than 440Hz, need to divide to reach correct result
		if m < A_CONCERT_PITCH:
			factor = 1 / factor
		
		return factor