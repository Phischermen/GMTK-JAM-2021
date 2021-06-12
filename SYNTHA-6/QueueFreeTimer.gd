extends Timer
class_name QueueFreeTimer

func _ready():
	connect("timeout", owner, "queue_free")
