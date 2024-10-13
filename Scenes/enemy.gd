extends CharacterBody2D

@export var health: int = 5
@export var speed: float = 40.0

@onready var player = get_node("/root/World/Player")
@onready var anim = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
	if health >= 3:
		walking()
	elif health >= 1:
		deterioration()
	
	
func walking():
	if velocity != Vector2.ZERO and health >= 0 and anim.animation != "hurt":
		anim.play("run_down")
		
func deterioration():
	anim.play("deterioration")

func take_damage():
	health -= 1
	
	if health >= 3:
		anim.play("hurt")
	elif health <= 3 and health >=1:
		anim.play("deteriationHurt")
		audio_stream_player_2d.play()
	elif health <= 0:
		anim.play("death")


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "death":
		queue_free()  
