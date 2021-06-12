extends Control


onready var heart = $HBoxContainer/Heart1.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	var amount = 5
	set_health(amount)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_max_health(amount):
	for child in $HBoxContainer.get_children():
		child.queue_free()
	for i in range(amount):
		$HBoxContainer.add_child(heart.duplicate())


func set_health(amount):
	
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
