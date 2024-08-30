extends CharacterBody2D

enum {
	SPAWN,
	IDLE,
	ATTACK
}

var state : int:
	set(value):
		state = value
		match state:
			SPAWN:
				spawn_state()
			IDLE:
				idle_state()
			ATTACK:
				attack_state()

var hpmob = 40
var speedmob = 200
var chase = false
var player
var damage = false
@export var bullet: PackedScene
@onready var anim = $AnimatedSprite2D

func _ready():
	state = SPAWN
	Functions.connect("player_positon_upd", Callable(self, "_on_player_position_upd"))

func _physics_process(_delta):
	var direction = (player - self.position).normalized()
	if chase == true :
		velocity = direction * speedmob
	else:
		velocity = Vector2(0,0)
	if direction.x < 0 :
		anim.flip_h = false
	else :
		anim.flip_h = true
	
	move_and_slide()
	
	$RayCast2D.look_at(player)
	
	if hpmob <= 0 :
		Global.scoremobs += 1
		queue_free()
	
func spawn_state():
	$RayCast2D/Sprite2D.hide()
	anim.play("spawn")
	await anim.animation_finished
	chase = true
	state = IDLE

func _on_timer_timeout():
	state = ATTACK

func attack_state():
	chase = false
	anim.play("shooting")
	await anim.animation_finished
	var b = bullet.instantiate()
	add_child(b)
	b.transform = $RayCast2D.transform
	state = IDLE


func _on_player_position_upd(player_pos):
	player = player_pos
	
func idle_state():
	anim.play("idle")
	$RayCast2D/Sprite2D.show()
	chase = true
