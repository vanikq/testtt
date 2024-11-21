extends CharacterBody2D

enum {
	MOVE
}

var state = MOVE
@export var bullet : PackedScene
var player_pos
@onready var anim = $AnimatedSprite2D
var current_target = null

func _ready():
	Global.hp = 100

func _physics_process(_delta):
	match state:
		MOVE:
			move_state()
	
	move_and_slide()
	
	if Global.hp <= 0:
		Global.hp = 0
		get_tree().change_scene_to_file("res://ui/menu.tscn")
		queue_free()
		
	if Global.hp >= 101:
		Global.hp = 100
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _process(_delta):
	current_target = get_closest_target()
	if current_target != null:
		$RayCast2D.look_at(current_target.global_position)

func move_state():
	var direction = Input.get_vector("a", "d", "w", "s")
	if direction:
		velocity = direction * Global.speed
	else:
		velocity = Vector2(0,0)

func shoot():
	var b = bullet.instantiate()
	add_child(b)
	b.transform = $RayCast2D.transform

func get_closest_target():
	var closest_enemy = null
	var closest_distance = INF
	for enemy in get_tree().get_nodes_in_group("hiti"):
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy
