extends Node2D

onready var drain = $"drains/Drain"
onready var door = $"Door"

func _process(delta):
	if 69 in drain.inputs:
		door.open()
	else:
		door.close()
		
	drain.inputs.clear()