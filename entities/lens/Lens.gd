extends StaticBody2D

onready var beam = $Beam

var inputs = {}

func _process(delta):
	if inputs.empty():
		return
		
	var hit = $Raycaster.raycast(global_position, global_rotation)
	if hit:
		var collider = hit["collider"]
		$Beam.set_enabled(true)
		$Beam.aim_at(hit["position"])
		if "inputs" in collider:
			for k in inputs:
				collider.inputs[k] = true
		
	inputs.clear()

func interact():
	$Rotator.do_rorate(self, global_rotation_degrees, global_rotation_degrees + 45, .5)

func push(direction):
	$Mover.push(self, global_position, direction, .5)
	