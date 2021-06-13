extends Node


var main_music = load("")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_music():
	
	$Music.stream = main_music
	$Music.play()
