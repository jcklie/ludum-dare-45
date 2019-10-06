extends AudioStreamPlayer

class_name PlayerAttenuatingAudioStreamPlayer

var _base_volume_db = 0
var _max_hearable_distance = 150
var _attenuation = 1
var _call = 0

func set_params(base_volume_db, max_hearable_distance, attenuation):
	self._base_volume_db = base_volume_db
	self._max_hearable_distance = max_hearable_distance
	self._attenuation = attenuation

func _process(delta):
	# don't update volume levels every call
	if _call % Globals.AUDIO_UPDATE_FREQ == 0:
		# taking some inspiration from audio_stream_player_2d.cpp
		var own_position = get_parent().global_position
		var distance_to_player = own_position.distance_to(Globals.player.global_position)
		if distance_to_player > self._max_hearable_distance:
			if playing:
				stop()
		else:
			if not playing:
				play()
			var multiplier = 1.0 - pow(distance_to_player / self._max_hearable_distance, self._attenuation)
			multiplier *= db2linear(self._base_volume_db)
			volume_db = linear2db(multiplier)

	_call = (_call + 1) % Globals.AUDIO_UPDATE_FREQ