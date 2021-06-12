extends "res://Enemy.gd"

class_name Dumb


export var dumbEnemySpeed = 200
var velocity = Vector2.ZERO
var player = null

export var health = 100
export var shootingDistance = 500

enum State {MOVING, SHOOTING}

var state = State.MOVING

var dogs = []



func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if player != null:
		velocity = position.direction_to(player.position) * dumbEnemySpeed
	else:
		velocity = Vector2.ZERO
		
	velocity = velocity.normalized()
	velocity = move_and_collide(velocity)

func take_damage(amount:int):
	health -= amount
	

#checks for player if they are in Area2D and are in group Dog
func _on_Area2D_body_entered(body):
	if body != self and body.is_in_group("Dog"):
		player = body

#no longer follows player if they leave Area2D
func _on_Area2D_body_exited(body):
	player = null

func _on_Timer_timeout():
	pass
