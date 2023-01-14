extends KinematicBody2D



var velocity = Vector2(0, 0)
var rng = RandomNumberGenerator.new()

signal hit_player

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	while velocity.x == 0:
		velocity.x = rng.randf_range(-1.0, 1.0)
	while velocity.y == 0:
		velocity.y = rng.randf_range(-1.0, 1.0)
		
	velocity = velocity.normalized() * Global.ballSpeed

	print(velocity)

func _physics_process(delta):
	var collision = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor() or is_on_ceiling():
		velocity.y *= -1
	if is_on_wall():
		velocity.x *= -1

	velocity = velocity.normalized() * Global.ballSpeed

func _on_playerCollision_body_entered(body):
	if body.name == "player":
		emit_signal("hit_player")
