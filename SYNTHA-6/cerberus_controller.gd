extends Node2D

onready var jack = $Jack 
onready var kahuna = $Kahuna 
onready var laguna = $Laguna
onready var solo_cerberus = [jack, kahuna, laguna]

onready var cerberus = $Cerberus

var cerberus_joined = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize joined
	for c in solo_cerberus:
		remove_child(c)
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("join_together_or_break_apart"):
		if cerberus_joined == false:
			# Make cerberus converge at the average position between the dogs
			var average_position = Vector2.ZERO
			for c in solo_cerberus:
				average_position += c.global_position
			average_position /= 3
			for c in solo_cerberus:
				var target_velocity = c.max_converge_speed * (c.position - average_position).normalized()
				c.attraction_velocity = c.attraction_velocity.linear_interpolate(target_velocity, c.acceleration * delta)
				
			
	pass
