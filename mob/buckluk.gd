extends CharacterBody2D


var hpmob = 2
var speedmob = 200
var chase = false
@onready var anim = $anim
var damage = false

func _ready():
	spawn_chase()

func _physics_process(_delta):
	var direction = (Global.plbody.position - self.position).normalized()
	if chase == true :
		anim.play("idle")
		velocity = direction * speedmob

	move_and_slide()

func _on_dead_body_entered(body):
	if damage == true:
		if body.is_in_group("Geogebra"):
			Global.hp -= 20

func dead():
	if hpmob <= 0:
		Global.scoremobs += 1
		queue_free()
	
func spawn_chase():
	anim.play("cade")
	await anim.animation_finished
	damage = true
	chase = true
