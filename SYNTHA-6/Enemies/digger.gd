extends "res://Dumb_Enemy.gd"


export var basic_goat_scene:PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func unearth():
	var inst = basic_goat_scene.instance()
	get_parent().add_child(inst)
	inst.position = position
	for s in get_signal_connection_list("enemy_died"):
		inst.connect(s["signal"], s["target"], s["method"])
	inst.stun(1)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
