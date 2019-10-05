extends Node2D

func _ready():
	var level_id = "2"
	var level_name = "res://levels/level{id}/Level{id}.tscn"
	var level = load(level_name.format({"id": level_id}))	
	add_child(level.instance())

