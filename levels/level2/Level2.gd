extends Node2D

onready var drain1 = $"drains/Drain1"
onready var drain4 = $"drains/Drain4"
onready var door = $Door

func _process(delta):	
	if "emitter1" in drain1.inputs and "emitter2" in drain4.inputs:
		door.open()
	else:
		door.close()