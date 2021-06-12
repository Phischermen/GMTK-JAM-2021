extends KinematicBody2D

const SHOOT_VELOCITY = Vector2(800, -400)

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
		_on_impact(collision.normal)

func launch(direction):
	#var scene = get_tree().current_scene
	# Find direction we're facing when firing fireball.
	# Detatch the fireball from player so they're not connected.
	#get_parent().remove_child(self)
	#scene.add_child(self)
	velocity = SHOOT_VELOCITY * Vector2(direction, 1)
	set_physics_process(true)

func _on_impact(normal : Vector2):
	velocity = velocity.bounce(normal)
	# Slowly stop the bounce of the fire ball.
	velocity *= 0.5
	
