extends "res://Actors/controllable_actor.gd"

#export var underground_texture : Texture
#onready var sprite = $Sprite
#onready var original_texture = $Sprite.texture

onready var l_walk = get_node("LagunaSprite/AnimationPlayer")

onready var animation_player = $LagunaSprite/AnimationPlayer
export var minimum_time_underground_to_trigger_unearth = 0.65

var is_underground = false
var time_underground = 0.0

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
	if (Input.is_action_pressed("ability_button") == false) and is_underground == true:
		# Go back to the surface if letting go of shift.
		if time_underground > minimum_time_underground_to_trigger_unearth:
			# Unearth diggers
			var someone_was_unearthed = false
			for digger in $UnearthArea.get_overlapping_bodies():
				digger.unearth()
				someone_was_unearthed = true
			if someone_was_unearthed:
				recieve_damage(0, Vector2.ZERO, 60)
			animation_player.play("Laguna(Dig)_Surfacing")
		else: 
			animation_player.play_backwards("Laguna(Dig)_Digging")
		time_underground = 0
		is_underground = false
	if is_underground:
		time_underground += delta
#    pass

func _physics_process(delta):
	var walk_animation_to_play = ""
	var idle_animation_to_play = ""
	if control_enabled == true and (animation_player.current_animation != "Laguna(Dig)_Digging" and animation_player.current_animation != "Laguna(Dig)_Surfacing"):
		if is_underground:
			walk_animation_to_play = "Laguna(Dig)_Underground"
			idle_animation_to_play = "Laguna(Dig)_Underground_Idle"
		else:
			walk_animation_to_play = "Laguna(Dig)_Run"
			idle_animation_to_play = "Laguna(Dig)_Idle"
		if Input.is_action_pressed("move_right"):
			l_walk.play(walk_animation_to_play)
			get_node("LagunaSprite").set_flip_h(false)
		
		if Input.is_action_pressed("move_left"):
			l_walk.play(walk_animation_to_play)
			get_node("LagunaSprite").set_flip_h(true)
			
		if Input.is_action_pressed("move_up"):
			l_walk.play(walk_animation_to_play)
			
		if Input.is_action_pressed("move_down"):
			l_walk.play(walk_animation_to_play)
			
		if Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right") || Input.is_action_just_released("move_up") || Input.is_action_just_released("move_down"):
			l_walk.play(idle_animation_to_play)
	else:
		l_walk.play(idle_animation_to_play)
