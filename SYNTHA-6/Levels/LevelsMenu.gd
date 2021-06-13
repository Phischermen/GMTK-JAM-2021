extends Control

onready var click_sound = get_node("UI_Click")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Level1Button_pressed():
	click_sound.play()
	get_tree().change_scene("res://Levels/Gameplay_Level 1.tscn")


func _on_Level2Button_pressed():
	click_sound.play()
	get_tree().change_scene("res://Levels/Gameplay_Level 2.tscn")


func _on_Level3Button_pressed():
	click_sound.play()
	get_tree().change_scene("res://Levels/Gameplay_Level 3.tscn")
