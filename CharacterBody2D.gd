extends CharacterBody2D


const SPEED = 300.0

func _physics_process(_delta):

	var direction = Input.get_vector("a", "d", "w", "s")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(0,0)

	move_and_slide()
