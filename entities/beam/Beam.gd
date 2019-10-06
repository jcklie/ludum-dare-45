extends Node2D

export(bool) var enabled = true
onready var paasp = $PolyphonicPAASP
onready var sprite = $Sprite
onready var sfx_buzz01 = preload("res://audio/sfx/buzz01_A.ogg")
onready var sfx_buzz02 = preload("res://audio/sfx/buzz02_A.ogg")

# TODO compute distance via https://gamedev.stackexchange.com/questions/44483/how-do-i-calculate-distance-between-a-point-and-an-axis-aligned-rectangle and set audio volume

func _ready():
	paasp.set_params([sfx_buzz01, sfx_buzz02], 0, 128, 1)
	set_enabled(enabled)
	
func set_notes(notes):
	paasp.set_notes(notes)

func aim_at(to_vec2_global):
	sprite.scale.x = (global_position - to_vec2_global).length()

func set_enabled(enabled):
	if enabled:
		sprite.visible = true
		paasp.set_enabled(true)
	else:
		sprite.visible = false
		paasp.set_enabled(false)