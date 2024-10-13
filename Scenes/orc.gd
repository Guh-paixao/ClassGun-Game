extends CharacterBody2D

@export var health: int = 3
@export var speed: float = 40.0

@onready var player = get_node("/root/World/Player")
@onready var anim = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
	if velocity != Vector2.ZERO and health >= 0 and anim.animation != "hurt":
		anim.play("run_down")

func take_damage():
	health -= 1
	anim.play("hurt")
	
	if health <= 0:
		anim.play("death")
		queue_free()
