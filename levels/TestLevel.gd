extends Node2D

onready var drain = $"drains/Drain"
onready var door = $"Door"

func _process(delta):
	if drain.inputs.empty():
		door.open()
	else:
		door.close()