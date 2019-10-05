extends KinematicBody2D

var speed = 250
var velocity = Vector2()
var selected_item = null

func get_input():
	# Detect up/down/left/right keystate and only move when pressed.
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if Input.is_action_just_pressed('ui_select') and selected_item:
		selected_item.interact()
		
func _physics_process(delta):
	get_input()
	
	var collision = move_and_collide(velocity * delta)
	if collision and collision.collider.name == "Emitter":
		selected_item = collision.collider
	else:
		selected_item = null
	
