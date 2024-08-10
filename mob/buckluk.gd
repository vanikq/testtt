extends CharacterBody2D

enum {
	IDLE,
	ATTACK
}
var state : int:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
			ATTACK:
				attack_state()


var hpmob = 40
var speedmob = 200
var chase = false
@onready var anim = $anim
var damage = false
@onready var deadzone = $dead/deadzone

func _ready():
	spawn_chase()

func _physics_process(_delta):
	var direction = (Global.plbody.position - self.position).normalized()
	if chase == true :
		anim.play("idle")
		velocity = direction * speedmob
	else :
		velocity = Vector2(0,0)
	
	move_and_slide()

	if hpmob <= 0 :
		Global.scoremobs += 1
		queue_free()

func spawn_chase():
	anim.play("cade")
	await anim.animation_finished
	damage = true
	chase = true

func _on_dead_body_entered(_body):
	state = ATTACK

func attack_state():
	if damage == true:
		Global.hp -= 20
	set_deferred("disable_mode", true)
	state = IDLE

func idle_state():
	await get_tree().create_timer(2).timeout
	set_deferred("disable_mode", false)
	state = ATTACK

func enable_deadzone():
	$dead/deadzone.set_enabled()

func disable_deadzone():
	$dead/deadzone.set_enabled(false)
