tool
extends Sprite

func calculate_aspect_ratio();
	material.set_shader_param("aspect_ratio", scale.y / scale.x)

func _on_Sprite_item_rect_changed():
	pass # Replace with function body.
