extends Node2D

const LEVEL_NAME = "current_level"
var level_number = 3
var level
var goal

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		_spawn_level(level_number)
		$SplashScreen.visible = false
	
func _spawn_level(level_id):
	if level:
		remove_child(level)
	
	var level_name = "res://levels/level{id}/Level{id}.tscn"
	var level_scene = load(level_name.format({"id": level_id}))	
	level = level_scene.instance()
	
	goal = level.get_node("Goal")
	goal.connect("body_entered", self, "_on_reach_goal")
	
	add_child(level)
	
func _on_reach_goal(body):
	if goal.is_enabled() and body.get_name() == "Player":
		level_number += 1
		_spawn_level(level_number)
