extends StaticBody2D

var MAX_RAYCAST_LENGTH = 2000
var ray_target;

func rotate_left():
	self.rotation_degrees -= 90;
	
func rotate_right():
	self.rotation_degrees += 90;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var m = Transform2D().rotated(global_rotation)
	var emitter_direction = m.xform(Vector2(0,-1))	# emitters currently point upwards by default	
	
	var world_phys_state = get_world_2d().direct_space_state
	var ray_end_pos = global_position + emitter_direction * MAX_RAYCAST_LENGTH
	var hit = world_phys_state.intersect_ray(global_position, ray_end_pos, [self], 5)	# impassable terrain, emitter, drain
	
	ray_target = to_local(hit["position"]) if "position" in hit else null
	update()
	
	self.rotation_degrees += 1

func _draw():
	if ray_target:
		draw_line(Vector2(0,0), ray_target, Color(255, 0, 0), 5)