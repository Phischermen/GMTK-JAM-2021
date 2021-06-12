extends Node2D

onready var jack = $Jack 
onready var kahuna = $Kahuna 
onready var laguna = $Laguna
onready var solo_cerberus = [jack, kahuna, laguna]

onready var cerberus = $Cerberus

onready var health_counter = $CanvasLayer/HeartCounter
export var health = 9 #TODO Make health not hardcoded
var iframes = 0

var cerberus_joined = true
var cerberus_has_joined_and_player_has_not_released_join_button = false

export var cerberus_join_distance = 40
export var dog_distance_from_split_origin = 50
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize health
	health_counter.set_max_health(health)
	# Initialize joined
	for c in solo_cerberus:
		remove_child(c)
	for d in get_tree().get_nodes_in_group("Dog"):
		d.connect("took_damage", self, "update_health")
	# Setup controls that disable cerbus
	jack.actions_that_enable_control_for_other_dogs = [jack.action_to_enable_control, laguna.action_to_enable_control, kahuna.action_to_enable_control]
	laguna.actions_that_enable_control_for_other_dogs = jack.actions_that_enable_control_for_other_dogs
	kahuna.actions_that_enable_control_for_other_dogs = jack.actions_that_enable_control_for_other_dogs


func _process(delta):
	# Iframes
	iframes = max(0, iframes - 1)
	visible = (iframes % 2) == 0
	# Get conjoin position
	var target_conjoin_point = Vector2.ZERO
	var one_cerbus_is_not_close_enough = false
	if cerberus_joined == false:
		target_conjoin_point = kahuna.global_position
		for c in solo_cerberus:
			if c.global_position.distance_to(target_conjoin_point) > cerberus_join_distance:
				one_cerbus_is_not_close_enough = true
	if Input.is_action_pressed("join_together_or_break_apart") && cerberus_has_joined_and_player_has_not_released_join_button == false:
		if cerberus_joined == false:
			# Make cerberus converge at the average position between the dogs
			for c in solo_cerberus:
				if c.global_position.distance_to(target_conjoin_point) < 5.0:
					continue
				var target_velocity = c.max_converge_speed * (target_conjoin_point - c.global_position).normalized()
				c.attraction_velocity = c.attraction_velocity.linear_interpolate(target_velocity, c.acceleration * delta)
			if one_cerbus_is_not_close_enough == false:
				join_cerberus(target_conjoin_point)
		else:
			split_cerberus(cerberus.position)
	else:
		for c in solo_cerberus:
			c.attraction_velocity = c.attraction_velocity.linear_interpolate(Vector2.ZERO, c.acceleration * delta)
	if Input.is_action_just_released("join_together_or_break_apart"):
		cerberus_has_joined_and_player_has_not_released_join_button = false


func join_cerberus(position):
	for c in solo_cerberus:
		remove_child(c)
	add_child(cerberus)
	cerberus.global_position = position
	cerberus_joined = true
	cerberus_has_joined_and_player_has_not_released_join_button = true


func split_cerberus(position):
	var angle = 0
	for c in solo_cerberus:
		add_child(c)
		#set dog position
		c.position = position + Vector2(dog_distance_from_split_origin * cos(angle), dog_distance_from_split_origin * sin(angle))
		# add by 2pi/3
		angle += 2.0944
	remove_child(cerberus)
	cerberus_joined = false
	cerberus_has_joined_and_player_has_not_released_join_button = true


func update_health(damage, knockback, _iframes):
	if iframes >= 0:
		return
	health = max(0, health - damage)
	iframes = _iframes
	health_counter.set_health(health)
