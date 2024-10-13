extends Control



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world_1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
