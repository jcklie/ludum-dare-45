extends Node2D

onready var drain = $"drains/Drain"
onready var door = $Door

func _process(delta):

	if "emitter1" in drain.inputs and "emitter2" in drain.inputs:
		door.open()
	else:
		door.close()
		
	drain.inputs.clear()