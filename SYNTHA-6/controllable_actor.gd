extends KinematicBody2D

export var action_to_enable_control:String = ""
export var max_speed = 64.0
export var acceleration = 6.0

var velocity:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if Input.is_action_pressed(action_to_enable_control):
		# Control is enabled
		var hinput =  Input.get_action_strength("move_right") - Input.get_action_strength("move_left") 
		var vinput = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		var target_velocity = Vector2(hinput, vinput) * max_speed
		velocity = velocity.linear_interpolate(target_velocity, acceleration)
		velocity = move_and_slide(velocity) * delta
