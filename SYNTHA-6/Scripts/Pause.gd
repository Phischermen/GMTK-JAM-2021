extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var pause_state = not get_tree().paused
		get_tree().paused = not get_tree().paused
		visible = pause_state
		print_debug("Bless you, sir")


