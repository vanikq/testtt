extends CharacterBody2D

var hpmob = 2
var speedmob = 100

func  _physics_process(_delta):
	var puzlik = $player/puzlik
	var direction = (puzlik.position - self.position).normalized()
	if Global.chase == true:
		velocity = direction * speedmob
	
	
	move_and_slide()



func _on_dead_body_entered(body):
	if body.is_in_group("geogebra"):
		Global.hp -= 1
