extends "res://Actors/controllable_actor.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var j_walk = get_node("JackSprite/AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.

func _physics_process(delta):
		if Input.is_action_pressed("jack_enable") == false:
			if Input.is_action_pressed("move_right"):
				j_walk.play("Jack(Strong)_Run")
				get_node("JackSprite").set_flip_h(false)
			
			if Input.is_action_pressed("move_left"):
				j_walk.play("Jack(Strong)_Run")
				get_node("JackSprite").set_flip_h(true)
				
			if Input.is_action_pressed("move_up"):
				j_walk.play("Jack(Strong)_Run")
				
			if Input.is_action_pressed("move_down"):
				j_walk.play("Jack(Strong)_Run")
				
			if Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right") || Input.is_action_just_released("move_up") || Input.is_action_just_released("move_down"):
				j_walk.play("Jack(Strong)_Idle")
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
