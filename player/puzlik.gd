extends CharacterBody2D

enum {
	MOVE
}

var state = MOVE
@export var bullet : PackedScene
var player_pos

func _ready():
	Global.hp = 100
	Global.plbody = self

func _physics_process(_delta):
	match state:
		MOVE:
			move_state()
	
	if Global.vray == false:
		$RayCast2D.hide()
	elif Global.vray == true:
		$RayCast2D.show()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	$RayCast2D.look_at(get_global_mouse_position())
	
	move_and_slide()
	
	if Global.hp <= 0:
		Global.hp = 0
		get_tree().change_scene_to_file("res://menu.tscn")
		Global.vray = false
	
	player_pos = self.position
	Functions.emit_signal("player_positon_upd", player_pos)

func shoot():
	if Global.vray == true:
		var b = bullet.instantiate()
		add_child(b)
		b.transform = $RayCast2D.transform

func move_state():
	var direction = Input.get_vector("a", "d", "w", "s")
	if direction:
		velocity = direction * Global.speed
	else:
		velocity = Vector2(0,0)

