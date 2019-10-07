extends Node2D

onready var goal = $Goal
onready var door = $doors/Door
onready var receiver_door = $receivers/ReceiverDoor
onready var receiver_goal = $receivers/ReceiverGoal
onready var emitter_door = $emitter/EmitterDoor
onready var emitter_goal = $emitter/EmitterGoal
onready var trace_door = $traces/TraceDoor
onready var trace_goal = $traces/TraceGoal

var win_condition = {69: true, 76: true}

func _ready():
	goal.enabled = false
	door.open()
	trace_door.modulate = Globals.TRACE_ACTIVATED
	trace_goal.modulate = Globals.TRACE_DEACTIVATED

func _process(delta):
	var door_should_open = receiver_door.inputs.size() == 1  and emitter_door.midi_note_number in receiver_door.inputs
	if door_should_open:
		trace_door.modulate = Globals.TRACE_ACTIVATED
		door.open()
	else:
		trace_door.modulate = Globals.TRACE_DEACTIVATED
		door.close()
	receiver_door.inputs.clear()
		
	var goal_should_enable = receiver_goal.inputs.size() == 1 and emitter_goal.midi_note_number in receiver_goal.inputs
	goal.set_enabled(goal_should_enable)
	if goal_should_enable:
		trace_goal.modulate = Globals.TRACE_ACTIVATED
	else:
		trace_goal.modulate = Globals.TRACE_DEACTIVATED
	receiver_goal.inputs.clear()