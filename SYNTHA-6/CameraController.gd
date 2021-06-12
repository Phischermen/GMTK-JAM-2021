extends Camera2D

#onready var player = get_node()
#collection array to iterate through positions of cerberus' 
#in order to find average position
var merged

var cerberus
var jack 
var kahuna 
var laguna
var solo_cerberus 

var zooming:Vector2 = Vector2.ZERO

func _process (delta):
	
	if merged == true:
		position.x = cerberus.position.x
		position.y = cerberus.position.y
	
	elif merged == false:
		print_debug ("OH GOD HE'S 3 DOGS")
		var average_position = Vector2.ZERO
		for c in solo_cerberus:
			average_position += c.global_position
		average_position /= 3
		
		global_position = average_position
		
		
		
