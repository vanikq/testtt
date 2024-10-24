extends Control

@onready var buttons = $buttons

func _on_start_pressed():
	buttons.play()
	await buttons.finished
	get_tree().change_scene_to_file("res://levels/leveltest.tscn")

func _on_quit_pressed():
	buttons.play()
	await buttons.finished
	get_tree().quit()
