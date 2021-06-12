extends KinematicBody2D

class_name Enemy

var navigation:Navigation2D
var path:PoolVector2Array

var target:Vector2

onready var navigation_timer:Timer = $NavigationTimer

signal enemy_died

# Called when the node enters the scene tree for the first time.
func _ready():
	navigation_timer.start(navigation_timer.wait_time + rand_range(-1, 1))
	update_path()

func _process(delta):
	z_index = position.y

func move_along_path(start_point:Vector2, distance:float):
	if path.size() == 0:
		update_path()
		return
	var distance_to_next_point = start_point.distance_to(path[0])
	var move_direction = (path[0] - start_point).normalized()
	if distance <= distance_to_next_point:
		move_and_slide(move_direction * distance)
	elif distance > 0.0:
		move_and_slide(move_direction * distance_to_next_point)
		move_along_path_helper(1, distance - distance_to_next_point)
		path.remove(0)
		$PathVisualizer.points = path

func move_along_path_helper(point_idx:int, distance:float):
	if point_idx >= path.size() - 1:
		return
	var start_point = path[point_idx]
	var next_point_idx = point_idx + 1
	var distance_to_next_point = start_point.distance_to(path[next_point_idx])
	var move_direction = (path[next_point_idx] - start_point).normalized()
	if distance <= distance_to_next_point and distance > 0.0:
		move_and_slide(move_direction * distance)
	else:
		move_and_slide(move_direction * distance_to_next_point)
		move_along_path_helper(next_point_idx, distance - distance_to_next_point)
		path.remove(point_idx)

func update_path():
	if navigation == null || target == null:
		return
	path = navigation.get_simple_path(position, target)
	$PathVisualizer.points = path
