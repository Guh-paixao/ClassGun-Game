extends CharacterBody2D

@export_category("Variables")
@export var move_speed: float = 84.0
@onready var anim = $AnimatedSprite2D

signal health_depleted


@export var health: float = 100.0 
var last_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	move()
	move_and_slide()
	
	const DAMAGE_RATE = 20.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()

func move() -> void:
	var direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if direction != Vector2.ZERO:
		last_direction = direction
		velocity = direction.normalized() * move_speed
		set_animation(direction)
	else:
		velocity = Vector2.ZERO
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
