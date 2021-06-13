extends Area2D


export var next_scene:PackedScene
var number_of_enemies = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var old_parent = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("connect_to_enemies")
	pass # Replace with function body.


func connect_to_enemies():
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.connect("enemy_died", self, "decrement_enemy")
		number_of_enemies += 1
	old_parent.remove_child(self)


func decrement_enemy():
	number_of_enemies -= 1
	if number_of_enemies == 0:
		old_parent.add_child(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if (body.is_in_group("Cerberus")):
		get_tree().change_scene_to(next_scene)
	pass # Replace with function body.
