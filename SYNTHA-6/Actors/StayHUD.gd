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


func update_hud(dog:String):
	defaultStay.visible = false
	jackStay.visible = false
	kahunaStay.visible = false
	lagunaStay.visible = false
	match dog:
		"Jack":
			jackStay.visible = true
		"Kahuna":
			kahunaStay.visible = true
		"Laguna":
			lagunaStay.visible = true
		"None":
			defaultStay.visible = true

