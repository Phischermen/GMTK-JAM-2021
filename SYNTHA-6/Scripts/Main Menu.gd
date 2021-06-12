extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://Levels/Gameplay_Level 1.tscn") 

func _on_LevelButton_pressed():
	get_tree().change_scene("res://Levels/LevelsMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditButton_pressed():
	get_tree().change_scene("res://Levels/Credits.tscn")
