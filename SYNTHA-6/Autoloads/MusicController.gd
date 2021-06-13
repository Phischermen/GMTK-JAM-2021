extends Node


var main_music = load("res://Music/heavy.mp3")

var end_music = load("res://Music/gameplay1.mp3")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_main_music():
	
	$Music.stream = main_music
	$Music.play()
	
func play_end_music():
	
	$Music.stream = end_music
	$Music.play()
