extends "res://Actors/controllable_actor.gd"

export var underground_texture : Texture
onready var sprite = $Sprite
onready var original_texture = $Sprite.texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Dig underground when we use the ability button.
	if Input.is_action_just_pressed("ability_button"):
		# If already underground, revert back to surface.
		if sprite.texture == underground_texture:
			sprite.texture = original_texture
		# Go underground.
		else:
			sprite.texture = underground_texture
#	pass
