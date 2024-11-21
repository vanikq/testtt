extends Area2D

var speed: int = 390

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("Geogebra"):
		Global.hp -= 10
		queue_free()
	if body.is_in_group("world"):
		queue_free()
