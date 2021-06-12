extends Camera2D

#onready var player = get_node()
#collection array to iterate through positions of cerberus' 
#in order to find average position
onready var merged = true

var cerberus
var jack 
var kahuna 
var laguna
var solo_cerberus 


func _process (delta):
	
	if merged == true:
		position.x = cerberus.position.x
		position.y = cerberus.position.y
	
	if merged == false:
		var average_position = Vector2.ZERO
		for c in solo_cerberus:
			average_position += c.global_position
		average_position /= 3
		
		position.x = average_position.x
		position.y = average_position.y
		
		
		
