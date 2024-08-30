extends Node2D
var enemy_list = [
	preload("res://mob/cubicbubick.tscn"),
	preload("res://mob/buckluk.tscn"),
	preload("res://mob/shootman.tscn")
]
var selected_enemy
var enemy_chance = [0.6, 0.1, 0.3]
@onready var labelsc = $CanvasLayer/Label
@onready var HPbar = $CanvasLayer/TextureProgressBar

func _ready():
	Global.scoremobs = 0
	Global.vray = false

func _physics_process(_delta):
	labelsc.text = "score " + str(Global.scoremobs)
	HPbar.value = Global.hp
	
func _on_spawnmobs_timeout():
	moba_spawn()

func moba_spawn():
	var random_value = randf()
	var accumulated_probability = 0.0
	for i in range(enemy_list.size()):
		accumulated_probability += enemy_chance[i]
		if random_value < accumulated_probability:
			selected_enemy = enemy_list[i]
			break
	whu_spawn()
func raid_spawn():
	_on_raidmobs_timeout()

func _on_raidmobs_timeout():
	for i in range(5):
		moba_spawn()

func whu_spawn():
	var scene = selected_enemy.instantiate()
	scene.position = Vector2(randi_range(1,1150),randi_range(1,655))
	$mobiku.add_child(scene)
