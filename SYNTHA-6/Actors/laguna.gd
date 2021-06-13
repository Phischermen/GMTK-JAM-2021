extends "res://Actors/controllable_actor.gd"

#export var underground_texture : Texture
#onready var sprite = $Sprite
#onready var original_texture = $Sprite.texture
onready var animation_player = $Laguna/AnimationPlayer
var is_underground = false
# Called when the node enters the scene tree for the first time.
func _ready():
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
			
#	pass
