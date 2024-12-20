extends Node2D

var enemy_list = [
	preload("res://mob/cubicbubick.tscn"),
	preload("res://mob/buckluk.tscn"),
	preload("res://mob/shootman.tscn")
]

var selected_enemy
var enemy_chance = [0.6, 0.1, 0.3]

var bocica = preload("res://inf/bocica.tscn")
@onready var labelsc = $CanvasLayer/MarginContainer/Label
@onready var HPbar = $CanvasLayer/MarginContainer/TextureProgressBar
@onready var spawnmobs = $mobiku/spawnmobs
@onready var raidmobs = $mobiku/raidmobs

func _ready():
	Global.scoremobs = 0

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
	scene.position = Vector2(randi_range(5,1140),randi_range(5,650))
	$mobiku.add_child(scene)

func pric_spawn():
	var bocic = bocica.instantiate()
	bocic.position = Vector2(randi_range(5,1140), randi_range(5,650))
	$pric.add_child(bocic)

func _on_pricspawnu_timeout():
	pric_spawn()
