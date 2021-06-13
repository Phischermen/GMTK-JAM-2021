extends "res://Dumb_Enemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Goat_enemy_died():
	disable_collision()
	$AnimationPlayer.play("Die")
	pass # Replace with function body.


func disable_collision():
	$CollisionShape2D.disabled = true
