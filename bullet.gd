extends Area2D

var speed = 500

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("hiti"):
		queue_free()
		body.queue_free()
	if body.is_in_group("world"):
		queue_free()
