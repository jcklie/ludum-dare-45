extends Area2D

export(bool) var enabled = true
onready var sprite = $Sprite
onready var sprite_enabled = preload("res://entities/goal/goal.png")
onready var sprite_disabled = preload("res://entities/goal/goal_disabled.png")

func _process(delta):
	if enabled:
		sprite.texture = sprite_enabled
	else:
		sprite.texture = sprite_disabled
		
func is_enabled():
	return self.enabled
	
func set_enabled(enabled):
	self.enabled = enabled