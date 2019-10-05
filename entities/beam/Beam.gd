extends Node2D

onready var sprite = $Sprite

func aim_at(to_vec2_global):
	sprite.scale.x = (global_position - to_vec2_global).length()