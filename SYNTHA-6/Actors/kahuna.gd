extends "res://Actors/controllable_actor.gd"


export var fireball_Scene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Use fireball every time we press the shift button.
	if Input.is_action_just_pressed("ability_button"):
		var fireball = fireball_Scene.instance()
		get_parent().add_child(fireball)
		fireball.global_position = global_position
		fireball.launch(Vector2.RIGHT)
#	pass
