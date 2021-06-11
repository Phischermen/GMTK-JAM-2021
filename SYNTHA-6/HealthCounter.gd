extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var amount = 9
	_setHealth(amount)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _setHealth(amount):
	var healthCount = 9;
	
	# Set the color of the hearts.
	for heart in $HBoxContainer.get_children():
		heart.modulate = Color.crimson
		amount -= 1
		
		if (amount >= 0):
			# Set the filled in hearts.			
			heart.modulate = Color.crimson
		else:
			# Set the damaged hearts.
			heart.modulate = Color(0.1875, 0.003676, 0)
