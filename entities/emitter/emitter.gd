extends StaticBody2D

export(int) var midi_note_number

var beam

func _ready():
	beam = $Beam
	beam.set_notes([midi_note_number])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hit = $Raycaster.raycast(global_position, global_rotation)
	
	if not hit.empty():
		beam.aim_at(hit["position"])
		
		var collider = hit["collider"]
		if "inputs" in collider:
			collider.inputs[midi_note_number] = true
	else:
		beam.set_enabled(false)
		
	update()
	
func interact():
	$Rotator.do_rorate(self, global_rotation_degrees, global_rotation_degrees + 45, .5)