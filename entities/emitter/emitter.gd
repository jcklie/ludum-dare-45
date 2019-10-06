extends StaticBody2D

export(int) var midi_note_number

onready var beam = $Beam

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hit = $Raycaster.raycast(global_position, global_rotation)
	
	if not hit.empty():
		beam.aim_at(hit["position"])
		
		var collider = hit["collider"]
		if "inputs" in collider:
			collider.inputs[midi_note_number] = true
	else:
		beam.aim_at(null)
		
	update()
	
func interact():
	$Rotator.do_rorate(self, global_rotation_degrees, global_rotation_degrees + 45, .5)