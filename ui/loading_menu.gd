extends CanvasLayer

@export var scene: String = "res://levels/leveltest.tscn"
@onready var anim = $AnimationPlayer

func _ready():
	ResourceLoader.load_threaded_request(Loader.scene)

func _on_animation_player_animation_finished(anim_name):
	var packed_scene = ResourceLoader.load_threaded_get(Loader.scene)
	if anim_name == "fade_to_black":
		get_tree().change_scene_to_packed(packed_scene)
		anim.play("fade_to_normal")
	
