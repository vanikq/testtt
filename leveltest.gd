extends Node2D

var book_preload = preload("res://mob/buckluk.tscn")
@onready var labelsc = $CanvasLayer/Label
@onready var label_2 = $CanvasLayer/Label2


func _ready():
	Global.scoremobs = 0
	Global.vray = false

func _physics_process(_delta):
	labelsc.text = "score " + str(Global.scoremobs)

	label_2.text = "hp " + str(Global.hp)


func _on_spawnmobs_timeout():
	buckluk_spawn()


func buckluk_spawn():
	var buck = book_preload.instantiate()
	buck.position = Vector2(randi_range(1,1150),randi_range(1,655))
	$mobiku.add_child(buck)

func raid_spawn():
	for i in range(10):
		var buck = book_preload.instantiate()
		buck.position = Vector2(randi_range(1, 1150), randi_range(1, 655))
		$mobiku.add_child(buck)



func _on_raidmobs_timeout():
	raid_spawn()
