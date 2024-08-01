extends Area2D

var speed = 500

func _physics_process(delta):
	position += transform.x * speed * delta
	
	


func _on_body_entered(body):
	if body.name == "buckluk":
		queue_free()
