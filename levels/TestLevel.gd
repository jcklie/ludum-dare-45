extends Node2D

onready var drain = $"drains/Drain"
onready var door = $"Door"

func _process(delta):
	if "c3" in drain.inputs:
		door.open()
	else:
		door.close()