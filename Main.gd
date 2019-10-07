extends Node2D

const MIN_LEVEL = 1
const MAX_LEVEL = 3

onready var status = "start"
var curr_level_number
var level
var goal

func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		if status == "start":
			status = "play"
			curr_level_number = MIN_LEVEL
			_spawn_level(curr_level_number)
			$SplashScreen.visible = false
		elif status == "play":	# reset level
			_spawn_level(curr_level_number)
		elif status == "end":	# reset game
			status = "start"
			$SplashScreen.visible = true
			$EndScreen.visible = false
	
func _spawn_level(level_number):
	if level:
		level.queue_free()
		remove_child(level)
		
	# game finished
	if level_number > MAX_LEVEL:
		status = "end"
		$EndScreen.visible = true
		return
	
	var level_name = "res://levels/level{id}/Level{id}.tscn".format({"id": level_number})
	var level_scene = load(level_name)

	level = level_scene.instance()
	goal = level.get_node("Goal")
	goal.connect("body_entered", self, "_on_reach_goal")
	add_child(level)
	
func _on_reach_goal(body):
	if goal.is_enabled() and body.get_name() == "Player":
		curr_level_number += 1
		_spawn_level(curr_level_number)
