extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready():
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.navigation = $Navigation2D
		
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
