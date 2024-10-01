extends CharacterBody2D

@export_category("Variables")
@export var move_speed: float = 84.0
@export var friction: float = 0.4
@export var acceleration: float = 0.4

@onready var anim = $AnimatedSprite2D

var last_direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	move()
	move_and_slide()

func move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direction != Vector2.ZERO:
		last_direction = _direction
		velocity.x = lerp(velocity.x, _direction.normalized().x * move_speed, acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * move_speed, acceleration)
		set_animation(_direction)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		velocity.y = lerp(velocity.y, 0.0, friction)
		
		if velocity.length() < 0.1:
			set_idle_animation()
		else:
			set_animation(last_direction)

func set_animation(direction: Vector2) -> void:
	if direction.y < 0:
		anim.play("run_up")
	elif direction.y > 0:
		anim.play("run_down")
	elif direction.x < 0:
		anim.play("run_left")
	elif direction.x > 0:
		anim.play("run_right")

func set_idle_animation() -> void:
	if last_direction.y < 0:
		anim.play("idle_up")
	elif last_direction.y > 0:
		anim.play("idle_down")
	elif last_direction.x < 0:
		anim.play("idle_left")
	elif last_direction.x > 0:
		anim.play("idle_right")
