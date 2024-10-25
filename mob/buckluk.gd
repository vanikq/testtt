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
				dead_state()
			ATTACK:
				attack_state()

var hpmob: int = 20
var speedmob:int = 510
var chase: bool = false
@onready var anim = $anim
@onready var deadzone = $deadnode/dead/deadzone

func _ready():
	state = SPAWN

func _physics_process(_delta):
	var player = get_tree().get_first_node_in_group("Geogebra")
	var direction = (player.position - self.position).normalized()
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
		hpmob = 1
		Global.scoremobs += 2
		state = DYING

func _on_dead_body_entered(body):
	if body.is_in_group("Geogebra"):
		state = ATTACK

func spawn_state():
	anim.play("cade")
	await anim.animation_finished
	chase = true
	state = IDLE

func attack_state():
	if chase == true:
		Global.hp -= 5
	deadzone.call_deferred("set_disabled", true)
	state = IDLE

func idle_state():
	await get_tree().create_timer(0.1).timeout
	deadzone.disabled = false

func dead_state():
	chase = false
	anim.play("dead")
	await anim.animation_finished
	queue_free()
