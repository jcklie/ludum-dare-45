extends StaticBody2D

const MAX_RAYCAST_LENGTH = 2000

export(String) var value

var ray_target
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var m = Transform2D().rotated(global_rotation)
	var emitter_direction = m.xform(Vector2(0,-1))	# emitters currently point upwards by default	
	
	var world_phys_state = get_world_2d().direct_space_state
	var ray_end_pos = global_position + emitter_direction * MAX_RAYCAST_LENGTH
	var hit = world_phys_state.intersect_ray(global_position, ray_end_pos, [self], 5)	# impassable terrain, emitter, drain
	
	if not hit.empty():
		ray_target = to_local(hit["position"])
		
		var collider = hit["collider"]
		
		if "inputs" in collider:
			collider.inputs[value] = true

	else:
		ray_target = null
		
	update()
	

func _draw():
	if ray_target:
		draw_line(Vector2(0,0), ray_target, Color(255, 0, 0), 5)
		
		
func interact():
	if not $Tween.is_active():
		$Tween.interpolate_property(self, 
			"global_rotation_degrees",
			global_rotation_degrees, global_rotation_degrees + 90, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
