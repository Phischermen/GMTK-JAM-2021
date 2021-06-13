extends KinematicBody2D

const SHOOT_VELOCITY = Vector2(600, -300)

var velocity = Vector2.ZERO
var timer = 3

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
	#var scene = get_tree().current_scene
	# Find direction we're facing when firing fireball.
	# Detatch the fireball from player so they're not connected.
	#get_parent().remove_child(self)
	#scene.add_child(self)
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
