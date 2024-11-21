extends CanvasLayer

@onready var buttons = $"../buttons"

@onready var play = $"../MarginContainer/HBoxContainer/VBoxContainer/CenterContainer/play"
@onready var settings = $"../MarginContainer/HBoxContainer/VBoxContainer/CenterContainer3/settings"
@onready var quit = $"../MarginContainer/HBoxContainer/VBoxContainer/CenterContainer2/quit"
@onready var lang = $settings/Panel/lang

@onready var label = $chosemenu/MarginContainer/Label
@onready var storymod = $chosemenu/MarginContainer/storymod
@onready var infinitymod = $chosemenu/MarginContainer/infinitymod


func _ready():
	updateUI()

func _on_english_pressed():
	buttons.play()
	await buttons.finished
	TranslationServer.set_locale("en")
	updateUI()

func _on_russian_pressed():
	buttons.play()
	await buttons.finished
	TranslationServer.set_locale("ru")
	updateUI()

func updateUI():
	play.text = tr("PLAY")
	settings.text = tr("SETTINGS")
	quit.text = tr("QUIT")
	lang.text = tr("LANG")
	label.text = tr("MODE")
	storymod.text = tr("STORY")
	infinitymod.text = tr("INFINITY")
