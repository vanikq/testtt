extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Geogebra"):
		Global.hp += 15
		queue_free()
	elif body.is_in_group("hiti"):
		body.queue_free()
		queue_free()
