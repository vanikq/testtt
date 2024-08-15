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
				pass
			ATTACK:
				pass

var hpmob = 80
var speedmob = 100
var chase = false
var player
var damage = false
@export var bullet: PackedScene
@onready var anim = $AnimatedSprite2D

func _ready():
	state = SPAWN
	
func _physics_process(delta):
	
	
	
	if hpmob <= 0 :
		Global.scoremobs += 4
		queue_free()
	
func spawn_state():
	anim.play("shooting")
	await anim.animation_finished
	chase = true
	state = IDLE

func _on_timer_timeout():
	state = ATTACK
