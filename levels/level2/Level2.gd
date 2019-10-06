extends Node2D

onready var drain1 = $"drains/Drain1"
onready var drain4 = $"drains/Drain4"
onready var door1 = $"doors/Door1"
onready var door2 = $"doors/Door2"

func _process(delta):
	if 69 in drain1.inputs:
		door1.open()
	else:
		door1.close()
		
	if 76 in drain4.inputs:
		door2.open()
	else:
		door2.close()

	drain1.inputs.clear()
	drain4.inputs.clear()