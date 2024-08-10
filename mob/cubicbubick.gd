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

var hpmob = 200
var speedmob = 100
var chase = false
@onready var anim = $AnimatedSprite2D
var damage = false
@onready var attackzone = $attack/attackzone

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

func _on_attack_body_entered(_body):
	state = ATTACK

func idle_state():
	await get_tree().create_timer(6).timeout
	set_deferred("disable_mode", false)
	state = ATTACK

func attack_state():
	if damage == true:
		Global.hp -= 60
	set_deferred("disable_mode", true)
	state = IDLE
