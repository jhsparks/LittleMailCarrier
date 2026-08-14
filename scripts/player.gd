extends CharacterBody2D

@export var speed: float = 80.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"

func _physics_process(_delta: float) -> void:
	# Get 2D movement direction vector
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Apply velocity and move
	velocity = input_direction * speed
	move_and_slide()
	
	# Handle animations
	update_animation(input_direction)

func update_animation(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		sprite.play("idle_" + last_direction)
		return
		
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			last_direction = "right"
		else:
			last_direction = "left"
	else:
		if dir.y > 0:
			last_direction = "down"
		else:
			last_direction = "up"
			
	sprite.play("walk_" + last_direction)
