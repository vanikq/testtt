extends Node

@onready var bottonsm = $"../bottonsm"
@onready var pause_menu = $"../CanvasLayer/pause menu"
var game_paused: bool = false

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		game_paused = !game_paused
		
	if game_paused == true:
		get_tree().paused = true
		pause_menu.show()
	else:
		get_tree().paused = false
		pause_menu.hide()

func _on_resume_pressed():
	bottonsm.play()
	await bottonsm.finished
	game_paused = !game_paused

func _on_quit_pressed():
	bottonsm.play()
	await bottonsm.finished
	get_tree().quit()

func _on_settings_pressed():
	bottonsm.play()
	await bottonsm.finished
	game_paused = false
	Loader.load_scene("res://ui/menu.tscn")

func _on_pause_pressed():
	game_paused = !game_paused
