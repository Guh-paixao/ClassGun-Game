extends Node2D

@onready var path_follow_2d: PathFollow2D = %PathFollow2D
@onready var player: CharacterBody2D = $Player
@onready var timer_game_over: Timer = $Timer_gameOver



func spawn_mob():
	var new_mob = preload("res://Scenes/enemy.tscn").instantiate()
	
	path_follow_2d.progress_ratio = randf()
	new_mob.global_position = path_follow_2d.global_position
	add_child(new_mob)

func spawn_plant():
	var new_plant = preload("res://Scenes/coqueiro.tscn").instantiate()
	path_follow_2d.progress_ratio =randf()
	new_plant.global_position = path_follow_2d.global_position
	add_child(new_plant)
	
func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
	
