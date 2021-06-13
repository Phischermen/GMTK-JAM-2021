extends KinematicBody2D

const SHOOT_VELOCITY = Vector2(600, -300)

var velocity = Vector2.ZERO

func _ready():
	#set_physics_process(false)
	pass

func _physics_process(delta):
	#velocity.y += Globals.gravity * delta
	
	# Apply velocity to the projectile.
	var collision = move_and_collide(velocity * delta)
	
	# Test collision
	if collision != null:
		_on_impact(collision.normal, collision.collider)

func launch(direction):
	# Make the fireball fly based on direction.
	if Input.is_action_pressed("move_left"):
		velocity = SHOOT_VELOCITY * Vector2(direction * -1)
	elif Input.is_action_pressed("move_right"):
		velocity = SHOOT_VELOCITY * Vector2(direction)
	set_physics_process(true)

func _on_impact(normal : Vector2, collided_entity):
	# Check if collided with enemy.
	if collided_entity.is_in_group("Enemy"):
		if (collided_entity.has_method("take_damage")):
			collided_entity.take_damage(50)
	else: # Collides with wall for example.
		velocity = velocity.bounce(normal)
		# Slowly stop the bounce of the fire ball.
		velocity *= 0.5
