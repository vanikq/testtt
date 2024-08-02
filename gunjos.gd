extends Area2D



func _on_body_entered(body):
	if body.name == "puzlik":
		queue_free()
		Global.vray = true
		Global.ray = true
		queue_free()
