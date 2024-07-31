extends CharacterBody2D


const SPEED = 300.0
@export var bullet : PackedScene
var vray = false

func _physics_process(_delta):

	var direction = Input.get_vector("a", "d", "w", "s")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(0,0)
	
	if Input.is_action_just_pressed("shoot"):
		if vray == true :
			shoot()
	
	$RayCast2D.look_at(get_global_mouse_position())
	
	move_and_slide()

func shoot():
	var b = bullet.instantiate()
	add_child(b)
	b.transform = $RayCast2D.transform

