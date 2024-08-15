@tool
extends Control

@export var world_index: int = 1
@export_file("*.tscn") var next_level_parth : String

func _ready():
	$Label.text = "world" + str(world_index)

func _process(_delta):
	if Engine.is_editor_hint():
		$Label.text = "world" + str(world_index)
