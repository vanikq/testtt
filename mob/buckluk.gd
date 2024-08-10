extends CharacterBody2D

enum {
	IDLE,
	ATTACK,
}
var state : int:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
			ATTACK:
				attack_state()

var can_atack = true
var hpmob = 20
var speedmob = 200
var chase = false
@onready var anim = $anim
var damage = false
@onready var deadzone = $dead/deadzone
var player
func _ready():
	spawn_chase()
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

func spawn_chase():
	anim.play("cade")
	await anim.animation_finished
	damage = true
	chase = true

func _on_dead_body_entered(_body):
	if can_atack :
		state = ATTACK

func attack_state():
	if damage == true:
		Global.hp -= 5
	can_atack = false
	await get_tree().create_timer(0.1).timeout
	set_deferred("disable_mode", true)
	can_atack = true
	state = IDLE

func idle_state():
	await get_tree().create_timer(0.1).timeout
	set_deferred("disable_mode", false)
