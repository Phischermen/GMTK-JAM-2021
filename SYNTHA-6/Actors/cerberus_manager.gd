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

var dog_with_disabled_controls = null
var action_that_enables_disabled_dog = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize health
	health_counter.set_max_health(health)
	# Initialize joined
	for c in solo_cerberus:
		remove_child(c)
	for d in get_tree().get_nodes_in_group("Dog"):
		d.connect("took_damage", self, "update_health")


func check_input_for_disabling_dog(action, dog):
	if Input.is_action_just_pressed(action):
		dog.control_enabled = false
		dog_with_disabled_controls = dog
		action_that_enables_disabled_dog = action


func _process(delta):
	# Set the status of each dog's control
	if dog_with_disabled_controls == null:
		# All dogs have their controls enabled.
		check_input_for_disabling_dog("jack_enable", jack)
		check_input_for_disabling_dog("kahuna_enable", kahuna)
		check_input_for_disabling_dog("laguna_enable", laguna)
	else:
		# One dog has it's control disabled
		if Input.is_action_pressed(action_that_enables_disabled_dog) == false:
			dog_with_disabled_controls.control_enabled = true
			dog_with_disabled_controls = null
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
	for c in solo_cerberus:
		add_child(c)
	kahuna.position = position + Vector2(40, 0)
	jack.position = position + Vector2(-40, 40)
	laguna.position = position + Vector2(-40, -40)
	remove_child(cerberus)
	cerberus_joined = false
	cerberus_has_joined_and_player_has_not_released_join_button = true


func update_health(damage, knockback, _iframes):
	if iframes >= 0:
		return
	health = max(0, health - damage)
	iframes = _iframes
	health_counter.set_health(health)
