extends StaticBody2D

var inputs = {}

func _ready():
	$Beam.visible = false

func _process(delta):
	if inputs.empty():
		return
		
	var hit = $Raycaster.raycast(global_position, global_rotation)
	
	if hit:
		var collider = hit["collider"]
		$Beam.visible = true
		$Beam.aim_at(hit["position"])
		if "inputs" in collider:
			for k in inputs:
				collider.inputs[k] = true

	else:
		$Beam.visible = false
		
	inputs.clear()

func interact():
	$Rotator.do_rorate(self, global_rotation_degrees, global_rotation_degrees + 45, .5)

	
	