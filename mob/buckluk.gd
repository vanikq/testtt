extends CharacterBody2D


var hpmob = 2
var speedmob = 200

func _physics_process(_delta):
	var direction = (Global.plbody.position - self.position).normalized()
	velocity = direction * speedmob

	move_and_slide()

func _on_dead_body_entered(body):
	if body.is_in_group("Geogebra"):
		Global.hp -= 1

func dead():
	if hpmob <= 0:
		Global.scoremobs += 1
		queue_free()
	
