extends "res://Enemy.gd"

class_name Dumb


export var dumbEnemySpeed = 200
var velocity = Vector2.ZERO
var player = null

export var health = 100
export var shootingDistance = 500

enum State {MOVING, SHOOTING, DYING}

var state = State.MOVING

var dogs = []



func _physics_process(delta):
	velocity = Vector2.ZERO
	match state:
		State.MOVING:
			if player != null && player.is_inside_tree() == true:
				velocity = global_position.direction_to(player.global_position) * dumbEnemySpeed * delta
			else:
				velocity = Vector2.ZERO
		State.DYING:
			pass
	velocity = move_and_collide(velocity)

func take_damage(amount:int):
	health -= amount
	if (health <= 0 && state != State.DYING):
		state = State.DYING
		emit_signal("enemy_died")
		

#checks for player if they are in Area2D and are in group Dog
func _on_Area2D_body_entered(body):
	print("detected")
	if body != self and body.is_in_group("Dog"):
		player = body

#no longer follows player if they leave Area2D
func _on_Area2D_body_exited(body):
	#player = null
	pass

