extends Node2D

const TILE_SIZE = 64

func push(obj, start, direction, duration):
	if $Tween.is_active():
		return
		
	$Tween.interpolate_property(obj, 
		"global_position",
		start, start + direction * TILE_SIZE, duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()