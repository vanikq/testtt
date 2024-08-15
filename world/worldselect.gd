extends Control

@onready var worlds: Array = [$worldicon, $worldicon2, $worldicon3, $worldicon4]
@onready var current_world: int = 0
func _ready():
	$playericon.global_position = worlds[current_world].global_position
	
func _input(event):
	if event.is_action_pressed("a") and current_world > 0:
		current_world -= 1
		$playericon.global_position = worlds[current_world].global_position
	if event.is_action_pressed("d") and current_world < worlds.size() - 1:
		current_world += 1
		$playericon.global_position = worlds[current_world].global_position
	if event.is_action_pressed("ui_accept"):
		pass
