extends KinematicBody2D

var speed = 250
var velocity = Vector2()
var selected_item = null
var touched_timer = 0

func _ready():
	Globals.player = self

func get_input():
	# Detect up/down/left/right keystate and only move when pressed.
	var direction = Vector2()
	if Input.is_action_pressed('ui_right'):
		direction.x += 1
	elif Input.is_action_pressed('ui_left'):
		direction.x -= 1
	
	if Input.is_action_pressed('ui_down'):
		direction.y += 1
	elif Input.is_action_pressed('ui_up'):
		direction.y -= 1
		
	velocity = direction.normalized() * speed
	
	if Input.is_action_just_pressed('ui_select') and selected_item and selected_item.has_method("interact"):
		selected_item.interact()
		
	# If user is pushing
	if selected_item != null and direction != Vector2() and touched_timer > 15 \
	   and selected_item.has_method("push"):
		# selected_item.push(direction)	
		touched_timer = 0
		
func _physics_process(delta):
	get_input()
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		selected_item = collision.collider
		touched_timer += 1
			
	else:
		selected_item = null
		touched_timer = 0