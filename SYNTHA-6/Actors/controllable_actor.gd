extends "res://Actors/actor.gd"

var control_enabled = true
export var control_always_enabled = true
#export var action_to_disable_control:String = ""
var actions_that_disable_control_for_other_dogs = [] # Initialized via cerbus manager
export var max_speed = 640.0
export var max_converge_speed = 640.0
export var acceleration = 6.0

export (int, 0, 500) var push = 100

var velocity:Vector2 = Vector2.ZERO
var move_velocity:Vector2 = Vector2.ZERO
var attraction_velocity = Vector2.ZERO

signal took_damage(damage, knockback, iframes)

# Called when the node enters the scene tree for the first time.
func _ready():
#	if InputMap.has_action(action_to_disable_control):
#		var event = InputMap.get_action_list(action_to_disable_control)[0]
#		$Label.text = OS.get_scancode_string(event.scancode)
#	else:
#		$Label.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var hinput =  Input.get_action_strength("move_right") - Input.get_action_strength("move_left") 
	var vinput = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	if control_enabled == true || control_always_enabled:
		# Control is enabled
		hinput =  Input.get_action_strength("move_right") - Input.get_action_strength("move_left") 
		vinput = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	else:
		#Control is not enabled
		hinput = 0
		vinput = 0
	var target_velocity = Vector2(hinput, vinput) * max_speed
	move_velocity = move_velocity.linear_interpolate(target_velocity, acceleration * delta)
	velocity = move_and_slide(move_velocity + attraction_velocity, Vector2.UP, false, 4, PI/4, false)
	
	#push objects
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is RigidBody2D:
			collision.collider.apply_central_impulse(-collision.normal * push)

func recieve_damage(damage, knockback, iframes):
	velocity = knockback
	emit_signal("took_damage", damage, knockback, iframes)
	
