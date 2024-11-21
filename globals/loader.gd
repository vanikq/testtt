extends Node

var loadingscreen = preload("res://ui/loading_menu.tscn")
var scene: String

func load_scene(scene_path: String):
	scene = scene_path
	var loadi = loadingscreen.instantiate()
	add_child(loadi)
