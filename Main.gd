extends Node2D

func _ready():
	var level_id = "1"
	var level_name = "res://levels/level{id}/Level{id}.tscn"
	var level_scene = load(level_name.format({"id": level_id}))	
	var level = level_scene.instance()
	
	var goal = level.get_node("Goal")
	goal.connect("body_entered", self, "_on_reach_goal")
	
	add_child(level)
	
func _on_reach_goal(body):
	if body.get_name() == "Player":
		print("Reached goal")

