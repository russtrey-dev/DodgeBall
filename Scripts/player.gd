extends KinematicBody2D

var velocity = Vector2(0,0)
var SPEED = 250
var GLIDE = 0.1


func _physics_process(delta):
	if Input.is_action_pressed("up"):
		velocity.y = -1 * SPEED
	elif Input.is_action_pressed("down"):
		velocity.y = 1 * SPEED
		
	if Input.is_action_pressed("left"):
		velocity.x = -1 * SPEED
	elif Input.is_action_pressed("right"):
		velocity.x = 1 * SPEED
		
	move_and_slide(velocity)

	velocity.x = lerp(velocity.x, 0, GLIDE)
	velocity.y = lerp(velocity.y, 0, GLIDE)
