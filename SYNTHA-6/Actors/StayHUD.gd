extends Control

# export var StayDefault : Texture
onready var defaultStay = $DefaultStay
onready var jackStay = $JackStay
onready var kahunaStay = $KahunaStay
onready var lagunaStay = $LagunaStay
var is_merged = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_merged == false:
		if Input.is_action_just_pressed("jack_enable"):
			# Set the HUD for Jack
			defaultStay.visible = false
			jackStay.visible = true
		elif Input.is_action_just_pressed("kahuna_enable"):
			# Set the HUD for Kahuna
			defaultStay.visible = false
			kahunaStay.visible = true
		elif Input.is_action_just_pressed("laguna_enable"):
			# Set the HUD for Laguna
			defaultStay.visible = false
			lagunaStay.visible = true
		elif Input.is_action_just_released("jack_enable") || Input.is_action_just_released("kahuna_enable") || Input.is_action_just_released("laguna_enable"):
			# Set the default HUD.
			defaultStay.visible = true
			jackStay.visible = false
			kahunaStay.visible = false
			lagunaStay.visible = false
