extends "res://Actors/controllable_actor.gd"


export var fireball_Scene : PackedScene

onready var k_walk = get_node("KahunaSprite/AnimationPlayer")
onready var fireball_sound = get_node("FireSound")
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Use fireball every time we press the shift button.
	if Input.is_action_just_pressed("ability_button"):
		var fireball = fireball_Scene.instance()
		get_parent().add_child(fireball)
		fireball.global_position = global_position
		fireball_sound.play()
		if $KahunaSprite.flip_h:
			fireball.launch(Vector2.LEFT)
		else:
			fireball.launch(Vector2.RIGHT)
#	pass

func _physics_process(delta):
		if control_enabled == true:
			if Input.is_action_pressed("move_right"):
				k_walk.play("Kahuna(Fire)_Run")
				get_node("KahunaSprite").set_flip_h(false)
			
			if Input.is_action_pressed("move_left"):
				k_walk.play("Kahuna(Fire)_Run")
				get_node("KahunaSprite").set_flip_h(true)
				
			if Input.is_action_pressed("move_up"):
				k_walk.play("Kahuna(Fire)_Run")
				
			if Input.is_action_pressed("move_down"):
				k_walk.play("Kahuna(Fire)_Run")
				
			if Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right") || Input.is_action_just_released("move_up") || Input.is_action_just_released("move_down"):
				k_walk.play("Kahuna(Fire)_Idle")
		else:
			k_walk.play("Kahuna(Fire)_Idle")
