tool
extends Node2D

func calculate_aspect_ratio();
	material.set_shader_param("aspect_ratio", scale.y / scale.x)


func _on_Lava_item_rect_changed():
	pass # Replace with function body.
