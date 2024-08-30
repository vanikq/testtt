extends CharacterBody2D

enum {
	SPAWN,
	IDLE,
	DYING,
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
			DYING:
				dying_state()
			ATTACK:
				attack_state()

var hpmob = 40
var speedmob = 250
var chase = false
@onready var anim = $AnimatedSprite2D
@onready var attackzone = $attack/attackzone
var player

func _ready():
	state = SPAWN
	Functions.connect("player_positon_upd", Callable(self, "_on_player_position_upd"))

func _physics_process(_delta):
	var direction = (player - self.position).normalized()
	if chase == true :
		if hpmob == 40 :
			anim.play("case")
		if hpmob == 20 :
			anim.play("casedamage")
		velocity = direction * speedmob
		if direction.x < 0 :
			anim.flip_h = false
		else :
			anim.flip_h = true
	else:
		velocity = Vector2(0,0)
	
	move_and_slide()
	
	if hpmob <= 0 :
		hpmob = 1
		Global.scoremobs += 1
		state = DYING


func _on_player_position_upd(player_pos):
	player = player_pos

func _on_attack_body_entered(body):
	if body.is_in_group("Geogebra"):
		state = ATTACK

func idle_state():
	await get_tree().create_timer(2).timeout
	attackzone.disabled = false

func attack_state():
	if chase == true:
		Global.hp -= 15
	attackzone.call_deferred("set_disabled", true)
	state = IDLE

func spawn_state():
	anim.play("cade")
	await anim.animation_finished
	chase = true
	state = IDLE

func dying_state():
	chase = false
	anim.play("dying")
	await anim.animation_finished
	queue_free()
