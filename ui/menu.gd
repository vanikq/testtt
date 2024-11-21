extends Control

@onready var buttons = $buttons

func _on_quit_pressed():
	buttons.play()
	await buttons.finished
	get_tree().quit()
