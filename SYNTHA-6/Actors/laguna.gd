extends "res://Actors/controllable_actor.gd"

#export var underground_texture : Texture
#onready var sprite = $Sprite
#onready var original_texture = $Sprite.texture

onready var l_walk = get_node("Laguna/AnimationPlayer")

onready var animation_player = $Laguna/AnimationPlayer
var is_underground = false
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Dig underground when we use the ability button.
	if Input.is_action_just_pressed("ability_button"):
		# Go underground.
		is_underground = true
		animation_player.play("Laguna(Dig)_Digging")
	if (Input.is_action_just_released("ability_button")):
			# Go back to the surface if letting go of shift.
			is_underground = false
			animation_player.play_backwards("Laguna(Dig)_Digging")
			
#    pass

func _physics_process(delta):
		if control_enabled == true:
			if Input.is_action_pressed("move_right"):
				l_walk.play("Laguna(Dig)_Run")
				get_node("Laguna").set_flip_h(false)
			
			if Input.is_action_pressed("move_left"):
				l_walk.play("Laguna(Dig)_Run")
				get_node("Laguna").set_flip_h(true)
				
			if Input.is_action_pressed("move_up"):
				l_walk.play("Laguna(Dig)_Run")
				
			if Input.is_action_pressed("move_down"):
				l_walk.play("Laguna(Dig)_Run")
				
			if Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right") || Input.is_action_just_released("move_up") || Input.is_action_just_released("move_down"):
				l_walk.play("Laguna(Dig)_Idle")
		else:
			l_walk.play("Laguna(Dig)_Idle")
