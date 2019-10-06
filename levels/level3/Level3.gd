extends Node2D

onready var rec_mul = $"receivers/ReceiverMulti"
onready var goal = $Goal
var goal_paasp

var win_condition = {69: true, 76: true}

onready var sfx_howl = preload("res://audio/sfx/howl01_A.ogg")

func _ready():
	# attach polyphonic sample player to goal which plays the notes of the win condition
	for node in goal.get_children():
		if node.name == "PolySampler":
			goal_paasp = node
	goal_paasp.set_params([sfx_howl], -5, 128, 1)
	goal_paasp.set_notes(win_condition.keys())

func _process(delta):
	var success = rec_mul.inputs.size() == 2 and 69 in rec_mul.inputs and 76 in rec_mul.inputs
	if success:
		goal.set_enabled(true)
		goal_paasp.set_enabled(false)
		$Traces.modulate = Globals.TRACE_ACTIVATED
	else:
		goal.set_enabled(false)
		goal_paasp.set_enabled(true)
		$Traces.modulate = Globals.TRACE_DEACTIVATED		
	
	rec_mul.check_error()
	rec_mul.inputs.clear()