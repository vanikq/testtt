extends CharacterBody2D

enum {
	SPAWN,
	CHASE,
	IDLE,
	ATTACK
}
var state : int:
	set(value):
		state = value
		match state:
			SPAWN:
				spawn_state()
			CHASE:
				pass
			IDLE:
				idle_state()
			ATTACK:
				attack_state()

var hpmob = 20
var speedmob = 200
var chase = false
@onready var anim = $anim
var damage = false
@onready var deadzone = $deadnode/dead/deadzone
var player
func _ready():
	state = SPAWN
	Functions.connect("player_positon_upd", Callable(self, "_on_player_position_upd"))
	
func _physics_process(_delta):
	var direction = (player - self.position).normalized()
	if chase == true :
		anim.play("chase")
		velocity = direction * speedmob
		if direction.x < 0 :
			anim.flip_h = false
		else :
			anim.flip_h = true
	else:
		velocity = Vector2(0,0)
		
	move_and_slide()

	if hpmob <= 0 :
		Global.scoremobs += 1
		queue_free()

func _on_player_position_upd(player_pos):
	player = player_pos

func _on_dead_body_entered(body):
	if body.is_in_group("Geogebra"):
		state = ATTACK
		
func spawn_state():
	anim.play("cade")
	await anim.animation_finished
	damage = true
	chase = true
	state = IDLE

func attack_state():
	if damage == true:
		Global.hp -= 5
	deadzone.call_deferred("set_disabled", true)
	state = IDLE

func idle_state():
	await get_tree().create_timer(0.1).timeout
	deadzone.disabled = false
