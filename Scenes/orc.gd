extends CharacterBody2D

var health = 3

@onready var player = get_node("/root/World/Player")
@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	play_walk()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 40.0
	move_and_slide()

func take_damage():
	health -= 1
	anim.play("hurt")
	
	if health <= 0:
		anim.play("dearth")
		queue_free()

func play_walk():
	if velocity != Vector2.ZERO && health < 1:
		anim.play("run_down")
