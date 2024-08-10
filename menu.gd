extends Control

@onready var clikmus = $clikmus


func _ready():
	pass 


func _process(_delta):
	pass


func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/leveltest.tscn")


func _on_quit_pressed():
	get_tree().quit()
