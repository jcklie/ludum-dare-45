extends KinematicBody2D

onready var beam = $Beam

var inputs = {}

func _process(delta):
	if inputs.empty():
		return
		
	var hit = $Raycaster.raycast(global_position, global_rotation)
	if hit:
		var collider = hit["collider"]
		if "inputs" in collider:
			for k in inputs:
				collider.inputs[k] = true
				
		$Beam.set_notes(inputs.keys())
		$Beam.set_enabled(true)
		$Beam.aim_at(hit["position"])
		
	inputs.clear()

func interact():
	$Rotator.do_rorate(self, global_rotation_degrees, global_rotation_degrees + 45, .5)

	