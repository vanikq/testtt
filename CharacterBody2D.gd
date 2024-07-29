extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta):

	var direction = Input.get_vector("w", "s", "a", "d")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(0,0)

	move_and_slide()
