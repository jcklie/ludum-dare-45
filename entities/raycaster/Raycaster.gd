extends Node2D

const MAX_RAYCAST_LENGTH = 2000

func raycast(position, rotation):
	var m = Transform2D().rotated(rotation)
	var direction = m.xform(Vector2(0,-1))	# emitters currently point upwards by default	
	
	var world_phys_state = get_world_2d().direct_space_state
	var ray_end_pos = position + direction * MAX_RAYCAST_LENGTH
	var hit = world_phys_state.intersect_ray(global_position, ray_end_pos, [self], 1)	# impassable terrain, emitter, drain
	
	return hit
