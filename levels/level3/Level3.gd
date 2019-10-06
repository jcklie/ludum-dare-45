extends Node2D

onready var rec_mul = $"receivers/ReceiverMulti"
onready var goal = $Goal

func _process(delta):

	var success = rec_mul.inputs.size() == 2 and 69 in rec_mul.inputs and 76 in rec_mul.inputs
	if success:
		goal.set_enabled(true)
		$Traces.modulate = Globals.TRACE_ACTIVATED
	else:
		goal.set_enabled(false)
		$Traces.modulate = Globals.TRACE_DEACTIVATED
	
	rec_mul.check_error()
	rec_mul.inputs.clear()