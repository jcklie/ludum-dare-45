extends StaticBody2D

export(String) var value
var ray_target

onready var beam = $Beam

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hit = $Raycaster.raycast(global_position, global_rotation)
	
	if not hit.empty():
		beam.aim_at(hit["position"])
		
		var collider = hit["collider"]
		if "inputs" in collider:
			collider.inputs[value] = true
	else:
		ray_target = null
		beam.scale = 0
		
	update()
	
func _draw():
	if ray_target:
		draw_line(Vector2(0,0), ray_target, Color(255, 0, 0), 5)

func interact():
	$Rotator.do_rorate(self, global_rotation_degrees, global_rotation_degrees + 45, .5)