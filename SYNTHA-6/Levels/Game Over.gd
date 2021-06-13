extends Node2D

onready var click_sound = get_node("UI_Click")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	MusicController.play_end_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TryAgainButton_pressed():
	click_sound.play()
	get_tree().change_scene("res://Levels/Main Menu.tscn") 
