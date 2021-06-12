extends VBoxContainer

func _ready():
	pass 
	
func _on_ResumeButton_pressed():
	print_debug("Bless you, sir")
	$Pause.hide()
	get_tree().paused = false

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://Levels/Main Menu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
