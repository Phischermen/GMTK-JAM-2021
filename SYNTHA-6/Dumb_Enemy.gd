extends "res://Enemy.gd"

class_name Dumb


export var dumbEnemySpeed = 200.0
export var dumbEnemyAcceleration = 6.0
var velocity = Vector2.ZERO
var player = null

export var health = 100
export var shootingDistance = 500

enum State {MOVING, SHOOTING, DYING, STUNNED}

var state = State.MOVING

var dogs = []

signal player_spotted
signal player_lost

func _physics_process(delta):
	var target_velocity = Vector2.ZERO
	match state:
		State.MOVING:
			if player != null && player.is_inside_tree() == true:
				target_velocity = global_position.direction_to(player.global_position) * dumbEnemySpeed
			else:
				pass
		State.DYING:
			pass
		State.STUNNED:
			pass
	velocity = lerp(velocity, target_velocity, dumbEnemyAcceleration * delta)
	velocity = move_and_slide(velocity)
	#Check for collision with player
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider is KinematicBody2D:
			if collision.collider.is_in_group("Dog"):
				collision.collider.recieve_damage(1, -collision.normal, 60)
				break


func take_damage(amount:int):
	health -= amount
	if (health <= 0 && state != State.DYING):
		state = State.DYING
		emit_signal("enemy_died")


func stun(duration):
	$StunTimer.start(duration)
	state = State.STUNNED

#checks for player if they are in Area2D and are in group Dog
func _on_Area2D_body_entered(body):
	if body != self and body.is_in_group("Dog"):
		player = body
		emit_signal("player_spotted")

#no longer follows player if they leave Area2D
func _on_Area2D2_body_exited(body):
	player = null
	emit_signal("player_lost")
	pass


func _on_StunTimer_timeout():
	state = State.MOVING
	pass # Replace with function body.
