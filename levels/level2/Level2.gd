extends Node2D

onready var drain1 = $"drains/Drain1"
onready var drain4 = $"drains/Drain4"
onready var door = $Door

func _process(delta):	
	if 69 in drain1.inputs and 76 in drain4.inputs:
		door.open()
	else:
		door.close()
		
	drain1.inputs.clear()
	drain4.inputs.clear()