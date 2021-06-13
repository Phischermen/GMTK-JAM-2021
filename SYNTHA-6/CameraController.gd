extends Camera2D

#onready var player = get_node()
#collection array to iterate through positions of cerberus' 
#in order to find average position
var merged = true

var cerberus
var jack 
var kahuna 
var laguna
var solo_cerberus 

export var min_zoom = 1.0  # closest camera can get
export var max_zoom = 7  # farthest camera can get

export var margins = Vector2(400,200) #buffer
export var move_speed = 0.5
export var zoom_speed = 0.25  

onready var screen_size = get_viewport_rect().size

func _ready():
	zoom = Vector2(min_zoom, min_zoom)
func _process (delta):
	var p = Vector2.ZERO
	
	if merged == true:
		position.x = cerberus.position.x
		position.y = cerberus.position.y
	
	elif merged == false:
		
		for c in solo_cerberus:
			p += c.position
		p /= solo_cerberus.size()
		position = lerp(position, p, move_speed)
		var r = Rect2(position, Vector2.ONE)
		
		for c in solo_cerberus:
			r = r.expand(c.position)
		r = r.grow_individual(margins.x, margins.y, margins.x, margins.y)
		var d = max(r.size.x, r.size.y)
		var z
		
		if r.size.x > r.size.y * screen_size.aspect():
			z = clamp(r.size.x / screen_size.x, min_zoom, max_zoom)
		else:
			z = clamp(r.size.y / screen_size.y, min_zoom, max_zoom)
		zoom = lerp(zoom, Vector2.ONE * z, zoom_speed)
		
