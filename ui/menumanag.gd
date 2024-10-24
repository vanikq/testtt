extends Node

@onready var buttons = $"../buttons"
@onready var settings = $"../settingsmenu/settings"

var musicfon: bool = true
var musicui: bool = true
var db_value: int = 1

func _on_settings_pressed():
	buttons.play()
	await buttons.finished
	settings.show()

func _on_back_pressed():
	buttons.play()
	await buttons.finished
	settings.hide()

func _process(_delta):
	if musicfon == true:
		AudioServer.set_bus_volume_db(1, db_value)
	else:
		AudioServer.set_bus_volume_db(1, -72)
		
	if musicui == true:
		AudioServer.set_bus_volume_db(2, 0)
	else:
		AudioServer.set_bus_volume_db(2, -72)

func _on_h_slider_value_changed(value):
	db_value = lerp(-20, 10, value)
	AudioServer.set_bus_volume_db(1, db_value)

func _on_musi_pressed():
	buttons.play()
	await buttons.finished
	musicfon = !musicfon

func _on_ui_pressed():
	buttons.play()
	await buttons.finished
	musicui = !musicui
