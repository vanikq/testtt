extends CharacterBody2D


@export var bullet : PackedScene

func _ready():
	pass

func _physics_process(_delta):
	var direction = Input.get_vector("a", "d", "w", "s")
	if direction:
		velocity = direction * Global.speed
	else:
		velocity = Vector2(0,0)
	
	if Global.vray == false:
		$RayCast2D.visible = false
	elif Global.vray == true:
		$RayCast2D.visible = true
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	$RayCast2D.look_at(get_global_mouse_position())
	

	Global.plbody = self
	
	move_and_slide()
	
	if Global.hp <= 0:
		get_tree().change_scene_to_file("res://menu.tscn")
		Global.vray = false
		Global.hp = 100
	

func shoot():
	if Global.vray == true:
		var b = bullet.instantiate()
		add_child(b)
		b.transform = $RayCast2D.transform



