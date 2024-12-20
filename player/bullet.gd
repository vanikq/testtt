extends Area2D

var speed = 400

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("hiti"):
		body.hpmob -= Global.damage
		queue_free()
	if body.is_in_group("world"):
		queue_free()
