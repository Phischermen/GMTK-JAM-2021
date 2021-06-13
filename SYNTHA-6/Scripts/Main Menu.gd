extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var click_sound = get_node("UI_Click")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	click_sound.play()
	get_tree().change_scene("res://Levels/Gameplay_Level 1.tscn") 

func _on_LevelButton_pressed():
	click_sound.play()
	get_tree().change_scene("res://Levels/LevelsMenu.tscn")

func _on_QuitButton_pressed():
	click_sound.play()
	get_tree().quit()

func _on_CreditButton_pressed():
	click_sound.play()
	get_tree().change_scene("res://Levels/Credits.tscn")
